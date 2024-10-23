import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/advice_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/affirmations_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/kanye_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/quotable_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

final List<QuoteDataSource> quoteDataSources = [
  KanyeQuoteRemoteDataSource(),
  AffirmationsQuoteRemoteDataSource(),
  AdviceQuoteRemoteDataSource(),
  QuotableQuoteRemoteDataSource(),
];

@injectable
class QuoteRepository {
  QuoteRepository();
  List<QuoteDataSource> dataSources = quoteDataSources;
  late int chosenIndex;
  int chooseIndex() {
    return Random().nextInt(dataSources.length);
  }

  Future<QuoteModel?> getQuoteModel() async {
    int retries = dataSources.length;
    chosenIndex = chooseIndex();
    try {
      return await retry(
        chosenIndex: chosenIndex,
        numberOfRetries: retries,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuoteModel?> retry<T>({
    required int chosenIndex,
    required int numberOfRetries,
  }) async {
    int retries = numberOfRetries;

    while (retries-- > 0) {
      try {
        final randomDataSource = dataSources[chosenIndex];
        return await randomDataSource.getQuoteData();
      } catch (e) {
        globalLogger.log('$e');
        if (chosenIndex < dataSources.length - 1) {
          chosenIndex++;
        } else {
          chosenIndex = 0;
        }
      }
    }
    {
      throw Exception('Error while getting quote');
    }
  }
}

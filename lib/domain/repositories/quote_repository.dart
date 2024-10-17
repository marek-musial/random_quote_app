import 'dart:math';
import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
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

  Future<QuoteModel?> getQuoteModel() async {
    final int chosenIndex = Random().nextInt(dataSources.length);
    try {
      final randomDataSource = dataSources[chosenIndex];
      return await randomDataSource.getQuoteData();
    } catch (e) {
      dev.log('[Time: ${DateTime.now().toString()}] $e');
      int otherIndex;
      if (chosenIndex < dataSources.length - 1) {
        otherIndex = chosenIndex + 1;
      } else {
        otherIndex = chosenIndex - 1;
      }
      final randomDataSource = dataSources[otherIndex];
      return await randomDataSource.getQuoteData();
    }
  }
}

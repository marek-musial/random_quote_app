import 'dart:math';

import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_source.dart';
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

class QuoteRepository {
  QuoteRepository();

  Future<QuoteModel?> getQuoteModel() async {
    final randomDataSource = quoteDataSources[Random().nextInt(quoteDataSources.length)];

    return await randomDataSource.getQuoteData();
  }
}

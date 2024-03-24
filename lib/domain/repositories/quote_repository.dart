import 'dart:math';

import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class QuoteRepository {
  QuoteRepository();

  final List<QuoteDataSource> dataSources = [
    FirstRemoteDataSource(),
  ];

  Future<QuoteModel?> getQuoteModel() async {
    final randomDataSource = dataSources[Random().nextInt(dataSources.length)];

    return await randomDataSource.getQuoteData();
  }
}

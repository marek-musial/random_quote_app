import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class AdviceQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'Advice Slip JSON API';
  @override
  final blurb = 'Generate random advice slips.\nCreated by Tom Kiss.';
  @override
  final link = 'https://api.adviceslip.com/';

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<String>(
        'https://api.adviceslip.com/advice',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }
      final map = jsonDecode(json);

      final quoteModel = QuoteModel(
        quote: map['slip']['advice'],
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class QuotableQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'Quotable';
  @override
  final blurb = 'Quotable is a free, open source quotations API. It was originally built as part of a FreeCodeCamp project.\nCreated by Luke Peavey.';
  @override
  final link = 'https://api.quotable.io';

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<List<dynamic>>(
        'https://api.quotable.io/quotes/random',
      );

      final jsons = response.data;
      if (jsons == null || jsons.isEmpty) {
        return null;
      }
      final Map<String, dynamic> json = jsons[0];

      final quoteModel = QuoteModel(
        quote: json['content'],
        author: json['author'],
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

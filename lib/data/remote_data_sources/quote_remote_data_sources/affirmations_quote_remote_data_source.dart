import 'package:dio/dio.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class AffirmationsQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'Affirmations';
  @override
  final blurb = 'A tiny api for fighting impostor syndrome and building example apps.\nCreated by Tilde Thurium.';
  @override
  final link = 'https://www.affirmations.dev/';

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        'https://www.affirmations.dev/',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      final quoteModel = QuoteModel(
        quote: json['affirmation'],
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

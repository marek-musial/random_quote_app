import 'package:dio/dio.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class KanyeQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'kanye.rest';
  @override
  final blurb = 'A free REST API for random Kanye West quotes (Kanye as a Service).\nCreated by Andrew Jazbec.';
  @override
  final link = 'https://kanye.rest/';

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        'https://api.kanye.rest',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      final quoteModel = QuoteModel(
        quote: json['quote'],
        author: 'Kanye West',
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

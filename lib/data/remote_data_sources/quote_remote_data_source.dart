import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

abstract class QuoteDataSource {
  Future<QuoteModel?> getQuoteData();
}

class FirstRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
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


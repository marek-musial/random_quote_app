import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'quotable_quote_remote_data_source.g.dart';
part 'quotable_quote_remote_data_source.freezed.dart';

@freezed
class QuotableResponse with _$QuotableResponse {
  factory QuotableResponse({
    required String content,
    required String? author,
  }) = _QuotableResponse;

  factory QuotableResponse.fromJson(Map<String, dynamic> json) => _$QuotableResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://api.quotable.io/quotes')
abstract class QuotableQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory QuotableQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _QuotableQuoteRemoteRetrofitDataSource;

  @GET('/random')
  Future<List<QuotableResponse>> getQuoteData();
}

class QuotableQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'Quotable';
  @override
  final blurb = 'Quotable is a free, open source quotations API. It was originally built as part of a FreeCodeCamp project.\nCreated by Luke Peavey.';
  @override
  final link = 'https://api.quotable.io';

  late QuotableQuoteRemoteRetrofitDataSource dataSource = //R
      QuotableQuoteRemoteRetrofitDataSource(dioClient.dio);

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dataSource.getQuoteData();
      final quoteModel = QuoteModel(
        quote: response.first.content,
        author: response.first.author,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Quoteble api unknown error');
    }
  }
}

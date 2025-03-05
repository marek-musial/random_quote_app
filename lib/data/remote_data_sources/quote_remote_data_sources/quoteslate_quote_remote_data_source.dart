import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'quoteslate_quote_remote_data_source.g.dart';
part 'quoteslate_quote_remote_data_source.freezed.dart';

@freezed
class QuoteslateResponse with _$QuoteslateResponse {
  factory QuoteslateResponse({
    required String quote,
    required String? author,
  }) = _QuoteslateResponse;

  factory QuoteslateResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$QuoteslateResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://quoteslate.vercel.app')
abstract class QuoteslateQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory QuoteslateQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _QuoteslateQuoteRemoteRetrofitDataSource;

  @GET('/api/quotes/random')
  Future<QuoteslateResponse> getQuoteData();
}

class QuoteslateQuoteRemoteDataSource extends QuoteDataSource {
  @override
  String get title => 'Quoteslate';
  @override
  String? get blurb => 'QuoteSlate provides access to a vast collection of inspirational quotes.\nCreated by Musheer Alam.';
  @override
  String? get link => 'https://quoteslate.vercel.app/';

// coverage:ignore-start
  late QuoteslateQuoteRemoteRetrofitDataSource dataSource = //R
      QuoteslateQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dataSource.getQuoteData();
      final quoteModel = QuoteModel(
        quote: response.quote,
        author: response.author,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? //R
          'Quoteble api unknown error');
    }
  }
}

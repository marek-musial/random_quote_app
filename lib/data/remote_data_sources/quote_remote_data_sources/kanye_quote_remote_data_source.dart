import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'kanye_quote_remote_data_source.g.dart';
part 'kanye_quote_remote_data_source.freezed.dart';

@freezed
class KanyeResponse with _$KanyeResponse {
  factory KanyeResponse({
    required String quote,
  }) = _KanyeResponse;

  factory KanyeResponse.fromJson(Map<String, dynamic> json) => _$KanyeResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://api.kanye.rest')
abstract class KanyeQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory KanyeQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _KanyeQuoteRemoteRetrofitDataSource;

  @GET('')
  Future<KanyeResponse> getQuoteData();
}

class KanyeQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'kanye.rest';
  @override
  final blurb = 'A free REST API for random Kanye West quotes (Kanye as a Service).\nCreated by Andrew Jazbec.';
  @override
  final link = 'https://kanye.rest/';

// coverage:ignore-start
  late KanyeQuoteRemoteRetrofitDataSource dataSource = //R
      KanyeQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dataSource.getQuoteData();
      final quoteModel = QuoteModel(
        quote: response.quote,
        author: 'Kanye West',
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Kanye api unknown error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'affirmations_quote_remote_data_source.g.dart';
part 'affirmations_quote_remote_data_source.freezed.dart';

@freezed
class AffirmationsResponse with _$AffirmationsResponse {
  factory AffirmationsResponse({
    required String affirmation,
  }) = _AffirmationsResponse;

  factory AffirmationsResponse.fromJson(Map<String, dynamic> json) => _$AffirmationsResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://www.affirmations.dev/')
abstract class AffirmationsQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory AffirmationsQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _AffirmationsQuoteRemoteRetrofitDataSource;

  @GET('')
  Future<AffirmationsResponse> getQuoteData();
}

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
      final dataSource = AffirmationsQuoteRemoteRetrofitDataSource(dioClient.dio);
      final response = await dataSource.getQuoteData();
      // final response = await dioClient.dio.get<Map<String, dynamic>>(
      //   'https://www.affirmations.dev/',
      // );

      // final json = response.data;

      // if (json == null) {
      //   return null;
      // }

      // final quoteModel = QuoteModel(
      //   quote: json['affirmation'],
      //   author: null,
      // );
      final quoteModel = QuoteModel(
        quote: response.affirmation,
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Affirmations api unknown error');
    }
  }
}

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

  factory AffirmationsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AffirmationsResponseFromJson(json);
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

class AffirmationsQuoteRemoteDataSource extends QuoteDataSource {
  @override
  String get  title => 'Affirmations';
  @override
  String? get  blurb => 'A tiny api for fighting impostor syndrome and building example apps.\nCreated by Tilde Thurium.';
  @override
  String? get  link => 'https://www.affirmations.dev/';

// coverage:ignore-start
  late AffirmationsQuoteRemoteRetrofitDataSource dataSource = //R
      AffirmationsQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await dataSource.getQuoteData();
      final quoteModel = QuoteModel(
        quote: response.affirmation,
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? //R
          'Affirmations api unknown error');
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'advice_quote_remote_data_source.g.dart';
part 'advice_quote_remote_data_source.freezed.dart';

@freezed
class AdviceResponse with _$AdviceResponse {
  factory AdviceResponse({
    required AdviceSlip slip,
  }) = _AdviceResponse;

  factory AdviceResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AdviceResponseFromJson(json);
}

@freezed
class AdviceSlip with _$AdviceSlip {
  factory AdviceSlip({
    required String advice,
  }) = _AdviceSlip;

  factory AdviceSlip.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AdviceSlipFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://api.adviceslip.com')
abstract class AdviceQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory AdviceQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _AdviceQuoteRemoteRetrofitDataSource;

  @GET('/advice')
  Future<String> getQuoteData();
}

class AdviceQuoteRemoteDataSource implements QuoteDataSource {
  @override
  final title = 'Advice Slip JSON API';
  @override
  final blurb = 'Generate random advice slips.\nCreated by Tom Kiss.';
  @override
  final link = 'https://api.adviceslip.com/';

// coverage:ignore-start
  late AdviceQuoteRemoteRetrofitDataSource dataSource = //R
      AdviceQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final jsonString = await dataSource.getQuoteData();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      final response = AdviceResponse.fromJson(jsonMap);
      final quoteModel = QuoteModel(
        quote: response.slip.advice,
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? //R
          'Advice api unknown error');
    }
  }
}

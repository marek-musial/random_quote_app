import 'dart:math';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'quotes_net_mittal_quote_remote_data_source.g.dart';
part 'quotes_net_mittal_quote_remote_data_source.freezed.dart';

@freezed
class QuotesNetMittalResponse with _$QuotesNetMittalResponse {
  factory QuotesNetMittalResponse({
    @JsonKey(name: 'quoteText') required String quote,
    required String? author,
  }) = _QuotesNetMittalResponse;

  factory QuotesNetMittalResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$QuotesNetMittalResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://florinbobis-quotes-net.hf.space')
abstract class QuotesNetMittalQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory QuotesNetMittalQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _QuotesNetMittalQuoteRemoteRetrofitDataSource;

  @GET('/quotes')
  Future<List<QuotesNetMittalResponse>> getQuoteData({
    @Query('pageNumber') required int pageNumber,
    @Query('pageSize') required int pageSize,
    @Query('dataset') String dataset = 'mittal',
  });
}

class QuotesNetMittalQuoteRemoteDataSource extends QuoteDataSource {
  @override
  String get title => 'Quotes-net API, Mittal dataset';
  @override
  String? get blurb =>
      "Inspirational, motivational, and thought-provoking quotes from some of the best collections available online!\nCreated by Florin Bobis.\nMittal dataset by Amit Mittal.";
  @override
  String? get link => 'https://huggingface.co/spaces/florinbobis/quotes-net/blob/main/README.md';

// coverage:ignore-start
  late QuotesNetMittalQuoteRemoteRetrofitDataSource dataSource = //R
      QuotesNetMittalQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    final randomPage = Random().nextInt(17) + 1;
    try {
      final responses = await dataSource.getQuoteData(
        pageNumber: randomPage,
        pageSize: 100,
      );
      final response = responses[Random().nextInt(
        responses.length,
      )];
      final quoteModel = QuoteModel(
        quote: response.quote,
        author: response.author,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? //R
          'Quotes net Mittal api unknown error');
    }
  }
}

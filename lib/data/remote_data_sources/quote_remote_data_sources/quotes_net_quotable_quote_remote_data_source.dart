import 'dart:math';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'quotes_net_quotable_quote_remote_data_source.g.dart';
part 'quotes_net_quotable_quote_remote_data_source.freezed.dart';

@freezed
class QuotesNetQuotableResponse with _$QuotesNetQuotableResponse {
  factory QuotesNetQuotableResponse({
    @JsonKey(name: 'quoteText') required String quote,
    required String? author,
  }) = _QuotesNetQuotableResponse;

  factory QuotesNetQuotableResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$QuotesNetQuotableResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://florinbobis-quotes-net.hf.space')
abstract class QuotesNetQuotableQuoteRemoteRetrofitDataSource {
  @factoryMethod
  factory QuotesNetQuotableQuoteRemoteRetrofitDataSource(
    Dio dio,
  ) = _QuotesNetQuotableQuoteRemoteRetrofitDataSource;

  @GET('/quotes')
  Future<List<QuotesNetQuotableResponse>> getQuoteData({
    @Query('pageNumber') required int pageNumber,
    @Query('pageSize') required int pageSize,
    @Query('dataset') String dataset = 'quotable',
  });
}

int randomizePage() => Random().nextInt(17) + 1; // total Quotable responses 1636

class QuotesNetQuotableQuoteRemoteDataSource extends QuoteDataSource {
  @override
  String get title => 'Quotes-net API, Quotable dataset';
  @override
  String? get blurb =>
      "Inspirational, motivational, and thought-provoking quotes from some of the best collections available online!\nCreated by Florin Bobis.\nQuotable dataset by Luke Peavey.";
  @override
  String? get link => 'https://huggingface.co/spaces/florinbobis/quotes-net/blob/main/README.md';

// coverage:ignore-start
  late QuotesNetQuotableQuoteRemoteRetrofitDataSource dataSource = //R
      QuotesNetQuotableQuoteRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final randomPage = randomizePage();
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
          'Quotes net Quotable api unknown error');
    }
  }
}

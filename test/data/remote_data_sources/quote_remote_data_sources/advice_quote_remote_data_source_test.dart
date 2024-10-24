import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/advice_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class MockAdviceQuoteRemoteRetrofitDataSource extends Mock implements AdviceQuoteRemoteRetrofitDataSource {}

void main() {
  late AdviceQuoteRemoteDataSource adviceDataSource;
  late MockAdviceQuoteRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockAdviceQuoteRemoteRetrofitDataSource();
      adviceDataSource = AdviceQuoteRemoteDataSource();
      adviceDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('getQuoteData', () {
    test(
      'should return QuoteModel when getQuoteData is successful',
      () async {
        final adviceResponse = AdviceResponse.fromJson(
          <String, dynamic>{
            'slip': <String, dynamic>{
              'advice': 'advice',
            },
          },
        );

        when(
          () => mockRetrofitDataSource.getQuoteData(),
        ).thenAnswer(
          (_) async => jsonEncode(adviceResponse),
        );

        final result = await adviceDataSource.getQuoteData();

        expect(
          result,
          isA<QuoteModel>()
              .having(
                (quoteModel) => quoteModel.quote,
                'quote',
                'advice',
              )
              .having(
                (quoteModel) => quoteModel.author,
                'author',
                null,
              ),
        );
        verify(
          () => mockRetrofitDataSource.getQuoteData(),
        ).called(1);
      },
    );

    test(
      'throws an Exception when DioException is thrown',
      () async {
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
            data: 'Server error',
          ),
        );

        when(
          () => mockRetrofitDataSource.getQuoteData(),
        ).thenThrow(dioError);

        expect(
          () => adviceDataSource.getQuoteData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

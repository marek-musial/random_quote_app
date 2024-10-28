import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/quoteslate_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class MockQuoteslateQuoteRemoteRetrofitDataSource extends Mock implements QuoteslateQuoteRemoteRetrofitDataSource {}

void main() {
  late QuoteslateQuoteRemoteDataSource quoteslateDataSource;
  late MockQuoteslateQuoteRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockQuoteslateQuoteRemoteRetrofitDataSource();
      quoteslateDataSource = QuoteslateQuoteRemoteDataSource();
      quoteslateDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('getQuoteData', () {
    test(
      'should return QuoteModel when getQuoteData is successful',
      () async {
        final quoteslateResponse = QuoteslateResponse.fromJson(
          <String, dynamic>{
            'quote': 'quote',
            'author': 'author',
          },
        );

        when(
          () => mockRetrofitDataSource.getQuoteData(),
        ).thenAnswer(
          (_) async => quoteslateResponse,
        );

        final result = await quoteslateDataSource.getQuoteData();

        expect(
          result,
          isA<QuoteModel>()
              .having(
                (quoteModel) => quoteModel.quote,
                'quote',
                'quote',
              )
              .having(
                (quoteModel) => quoteModel.author,
                'author',
                'author',
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
          () => quoteslateDataSource.getQuoteData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/kanye_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class MockKanyeQuoteRemoteRetrofitDataSource extends Mock implements KanyeQuoteRemoteRetrofitDataSource {}

void main() {
  late KanyeQuoteRemoteDataSource kanyeDataSource;
  late MockKanyeQuoteRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockKanyeQuoteRemoteRetrofitDataSource();
      kanyeDataSource = KanyeQuoteRemoteDataSource();
      kanyeDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('getQuoteData', () {
    test(
      'should return QuoteModel when getQuoteData is successful',
      () async {
        final kanyeResponse = KanyeResponse.fromJson(
          <String, dynamic>{
            'quote': 'quote',
          },
        );

        when(
          () => mockRetrofitDataSource.getQuoteData(),
        ).thenAnswer(
          (_) async => kanyeResponse,
        );

        final result = await kanyeDataSource.getQuoteData();

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
                'Kanye West',
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
          () => kanyeDataSource.getQuoteData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

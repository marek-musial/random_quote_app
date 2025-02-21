import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/affirmations_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class MockAffirmationsQuoteRemoteRetrofitDataSource extends Mock implements AffirmationsQuoteRemoteRetrofitDataSource {}

void main() {
  late AffirmationsQuoteRemoteDataSource affirmationsDataSource;
  late MockAffirmationsQuoteRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockAffirmationsQuoteRemoteRetrofitDataSource();
      affirmationsDataSource = AffirmationsQuoteRemoteDataSource();
      affirmationsDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('AffirmationsQuoteRemoteDataSource', () {
    test('instantiates data source with predetermined values', () {
      expect(
        affirmationsDataSource.title,
        'Affirmations',
      );
      expect(
        affirmationsDataSource.blurb,
        'A tiny api for fighting impostor syndrome and building example apps.\nCreated by Tilde Thurium.',
      );
      expect(
        affirmationsDataSource.link,
        'https://www.affirmations.dev/',
      );
    });
  });

  group('getQuoteData', () {
    test(
      'should return QuoteModel when getQuoteData is successful',
      () async {
        final affirmationsResponse = AffirmationsResponse.fromJson(
          <String, dynamic>{
            'affirmation': 'affirmation',
          },
        );

        when(
          () => mockRetrofitDataSource.getQuoteData(),
        ).thenAnswer(
          (_) async => affirmationsResponse,
        );

        final result = await affirmationsDataSource.getQuoteData();

        expect(
          result,
          isA<QuoteModel>()
              .having(
                (quoteModel) => quoteModel.quote,
                'quote',
                'affirmation',
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
          () => affirmationsDataSource.getQuoteData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

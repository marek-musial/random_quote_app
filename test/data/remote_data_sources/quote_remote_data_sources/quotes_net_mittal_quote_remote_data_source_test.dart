import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/quotes_net_mittal_quote_remote_data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class MockQuotesNetMittalQuoteRemoteRetrofitDataSource extends Mock implements QuotesNetMittalQuoteRemoteRetrofitDataSource {}

void main() {
  late QuotesNetMittalQuoteRemoteDataSource quotesNetMittalDataSource;
  late MockQuotesNetMittalQuoteRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockQuotesNetMittalQuoteRemoteRetrofitDataSource();
      quotesNetMittalDataSource = QuotesNetMittalQuoteRemoteDataSource();
      quotesNetMittalDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('QuotesNetMittalQuoteRemoteDataSource', () {
    test('instantiates data source with predetermined values', () {
      expect(
        quotesNetMittalDataSource.title,
        'Quotes-net API, Mittal dataset',
      );
      expect(
        quotesNetMittalDataSource.blurb,
        "Inspirational, motivational, and thought-provoking quotes from some of the best collections available online!\nCreated by Florin Bobis.\nMittal dataset by Amit Mittal.",
      );
      expect(
        quotesNetMittalDataSource.link,
        'https://huggingface.co/spaces/florinbobis/quotes-net/blob/main/README.md',
      );
    });
  });

  group('randomizePage', () {
    test(
      'return random int within range',
      () {
        expect(
          randomizePage(),
          inInclusiveRange(1, 370),
        );
      },
    );
  });

  group('getQuoteData', () {
    test(
      'should return QuoteModel when getQuoteData is successful',
      () async {
        final quotesNetMittalResponse = [
          QuotesNetMittalResponse.fromJson(
            <String, dynamic>{
              'quoteText': 'quote',
              'author': 'author',
            },
          ),
        ];

        when(
          () => mockRetrofitDataSource.getQuoteData(
            pageNumber: any(
              named: 'pageNumber',
            ),
            pageSize: any(
              named: 'pageSize',
            ),
          ),
        ).thenAnswer(
          (_) async => quotesNetMittalResponse,
        );

        final result = await quotesNetMittalDataSource.getQuoteData();

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
          () => mockRetrofitDataSource.getQuoteData(
            pageNumber: any(
              named: 'pageNumber',
            ),
            pageSize: any(
              named: 'pageSize',
            ),
          ),
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
          () => mockRetrofitDataSource.getQuoteData(
            pageNumber: any(
              named: 'pageNumber',
            ),
            pageSize: any(
              named: 'pageSize',
            ),
          ),
        ).thenThrow(dioError);

        expect(
          () => quotesNetMittalDataSource.getQuoteData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

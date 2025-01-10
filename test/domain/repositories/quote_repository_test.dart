import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

class MockQuoteDataSource extends Mock implements QuoteDataSource {
  Future<QuoteModel?> getQuoteModel();
}

class MockLogger extends Mock implements Logger {}

main() {
  globalLogger = MockLogger();
  late QuoteRepository quoteRepository;
  late MockQuoteDataSource mockQuoteDataSource1;
  late MockQuoteDataSource mockQuoteDataSource2;
  QuoteModel quoteModel = QuoteModel(
    quote: 'quoteUrl',
    author: 'author',
  );

  group('getQuoteModel', () {
    setUp(() {
      mockQuoteDataSource1 = MockQuoteDataSource();
      mockQuoteDataSource2 = MockQuoteDataSource();
      quoteRepository = QuoteRepository();

      when(
        () => mockQuoteDataSource1.getQuoteData(),
      ).thenAnswer(
        (_) async => quoteModel,
      );
      when(
        () => mockQuoteDataSource2.getQuoteData(),
      ).thenThrow(
        (_) async => Exception(''),
      );
    });

    test(
      'gets quote model data from the data source',
      () async {
        quoteRepository.dataSources = [
          mockQuoteDataSource1,
          mockQuoteDataSource1,
          mockQuoteDataSource1,
        ];
        final QuoteModel quoteModel = QuoteModel(
          quote: 'quoteUrl',
          author: 'author',
        );
        when(
          () => mockQuoteDataSource1.getQuoteData(),
        ).thenAnswer(
          (_) async => quoteModel,
        );

        final resultQuoteModel = await quoteRepository.getQuoteModel();

        expect(resultQuoteModel, quoteModel);
        verify(
          () => mockQuoteDataSource1.getQuoteData(),
        ).called(1);
      },
    );

    test(
      'on error on every data call in the list throws an error, logs every failed attempt',
      () async {
        quoteRepository.dataSources = [
          mockQuoteDataSource2,
          mockQuoteDataSource2,
          mockQuoteDataSource2,
        ];

        expect(
          quoteRepository.getQuoteModel,
          throwsA('Error while getting quote. Check your network connection.'),
        );
        verify(
          () => mockQuoteDataSource2.getQuoteData(),
        ).called(
          quoteRepository.dataSources.length,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          quoteRepository.dataSources.length,
        );
      },
    );
  });
}

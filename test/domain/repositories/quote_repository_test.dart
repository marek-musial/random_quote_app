import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

class MockQuoteDataSource extends Mock implements QuoteDataSource {
  Future<QuoteModel?> getQuoteModel();
}

class MockQuoteRepository extends Mock implements QuoteRepository {
  @override
  Future<QuoteModel?> retry<T>({
    required int chosenIndex,
    required int numberOfRetries,
  }) async {
    int retries = numberOfRetries;

    while (retries-- > 0) {
      try {
        final randomDataSource = dataSources[chosenIndex];
        return await randomDataSource.getQuoteData();
      } catch (e) {
        globalLogger.log('$e');
        if (chosenIndex < dataSources.length - 1) {
          chosenIndex++;
        } else {
          chosenIndex = 0;
        }
      }
    }
    {
      throw Exception('Error while getting quote');
    }
  }
}

class MockLogger extends Mock implements Logger {}

main() {
  globalLogger = MockLogger();
  late MockQuoteRepository mockQuoteRepository;
  late MockQuoteDataSource mockQuoteDataSource1;
  late MockQuoteDataSource mockQuoteDataSource2;
  final QuoteModel quoteModel = QuoteModel(
    quote: 'quote',
    author: 'author',
  );

  group('getQuoteModel', () {
    setUp(
      () {
        mockQuoteDataSource1 = MockQuoteDataSource();
        mockQuoteDataSource2 = MockQuoteDataSource();
        mockQuoteRepository = MockQuoteRepository();

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
      },
    );

    test(
      'gets quote model data from the data source',
      () async {
        when(
          () => mockQuoteRepository.dataSources,
        ).thenReturn(
          [
            mockQuoteDataSource1,
            mockQuoteDataSource1,
            mockQuoteDataSource1,
          ],
        );
        when(
          () => mockQuoteRepository.chooseIndex(),
        ).thenReturn(2);
        when(
          () => mockQuoteRepository.getQuoteModel(),
        ).thenAnswer(
          (_) async {
            return mockQuoteRepository.retry(
              chosenIndex: mockQuoteRepository.chooseIndex(),
              numberOfRetries: 3,
            );
          },
        );

        final resultQuoteModel = await mockQuoteRepository.getQuoteModel();

        expect(resultQuoteModel, quoteModel);
        verify(
          () => mockQuoteDataSource1.getQuoteData(),
        ).called(1);
      },
    );

    test(
      'on error when getting data, gets a quote model data from another data source in the list until success, logs every failed attempt',
      () async {
        when(
          () => mockQuoteRepository.dataSources,
        ).thenReturn(
          [
            mockQuoteDataSource2,
            mockQuoteDataSource1,
            mockQuoteDataSource2,
            mockQuoteDataSource2,
          ],
        );

        when(
          () => mockQuoteRepository.chooseIndex(),
        ).thenReturn(2);

        when(
          () => mockQuoteRepository.getQuoteModel(),
        ).thenAnswer(
          (_) async {
            return mockQuoteRepository.retry(
              chosenIndex: mockQuoteRepository.chooseIndex(),
              numberOfRetries: 4,
            );
          },
        );

        final resultQuoteModel = await mockQuoteRepository.getQuoteModel();

        expect(resultQuoteModel, quoteModel);
        verify(
          () => mockQuoteDataSource1.getQuoteData(),
        ).called(1);
        verify(
          () => mockQuoteDataSource2.getQuoteData(),
        ).called(
          mockQuoteRepository.dataSources.length - 1,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          mockQuoteRepository.dataSources.length - 1,
        );
      },
    );

    test(
      'on error on every data call in the list throws an error, logs every failed attempt',
      () async {
        when(
          () => mockQuoteRepository.dataSources,
        ).thenReturn(
          [
            mockQuoteDataSource2,
            mockQuoteDataSource2,
            mockQuoteDataSource2,
          ],
        );

        when(
          () => mockQuoteRepository.chooseIndex(),
        ).thenReturn(2);

        when(
          () => mockQuoteRepository.getQuoteModel(),
        ).thenAnswer(
          (_) async {
            return mockQuoteRepository.retry(
              chosenIndex: mockQuoteRepository.chooseIndex(),
              numberOfRetries: 3,
            );
          },
        );

        expect(
          mockQuoteRepository.getQuoteModel,
          throwsException,
        );
        verify(
          () => mockQuoteDataSource2.getQuoteData(),
        ).called(
          mockQuoteRepository.dataSources.length,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          mockQuoteRepository.dataSources.length,
        );
      },
    );
  });
}

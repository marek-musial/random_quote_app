import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

class MockQuoteDataSource extends Mock implements QuoteDataSource {
  Future<QuoteModel?> getQuoteModel();
}

main() {
  late QuoteRepository quoteRepository;
  late MockQuoteDataSource mockQuoteDataSource1;
  late MockQuoteDataSource mockQuoteDataSource2;

  group('getQuoteModel', () {
    setUp(() {
      mockQuoteDataSource1 = MockQuoteDataSource();
      mockQuoteDataSource2 = MockQuoteDataSource();
      quoteRepository = QuoteRepository();
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
      'on error when getting data, gets a quote model data from another data source in the list',
      () async {
        quoteRepository.dataSources = [
          mockQuoteDataSource1,
          mockQuoteDataSource2,
          mockQuoteDataSource1,
        ];
        final QuoteModel quoteModel = QuoteModel(
          quote: 'quoteUrl',
          author: 'author',
        );
        when(
          () => mockQuoteDataSource1.getQuoteData(),
        ).thenThrow(
          (_) async => Exception(''),
        );
        when(
          () => mockQuoteDataSource2.getQuoteData(),
        ).thenAnswer(
          (_) async => quoteModel,
        );

        final resultQuoteModel = await quoteRepository.getQuoteModel();

        expect(resultQuoteModel, quoteModel);
        verify(
          () => mockQuoteDataSource2.getQuoteData(),
        ).called(1);
      },
    );
  });
}
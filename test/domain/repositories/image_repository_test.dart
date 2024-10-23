import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';

class MockImageDataSource extends Mock implements ImageDataSource {
  Future<ImageModel?> getImageModel();
}

class MockImageRepository extends Mock implements ImageRepository {
  @override
  Future<ImageModel?> retry<T>({
    required int chosenIndex,
    required int numberOfRetries,
  }) async {
    int retries = numberOfRetries;

    while (retries-- > 0) {
      try {
        final randomDataSource = dataSources[chosenIndex];
        return await randomDataSource.getImageData();
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
  late MockImageRepository mockImageRepository;
  late MockImageDataSource mockImageDataSource1;
  late MockImageDataSource mockImageDataSource2;
  final ImageModel imageModel = ImageModel(
    imageUrl: 'imageUrl',
    author: 'author',
  );

  group('getImageModel', () {
    setUp(
      () {
        mockImageDataSource1 = MockImageDataSource();
        mockImageDataSource2 = MockImageDataSource();
        mockImageRepository = MockImageRepository();

        when(
          () => mockImageDataSource1.getImageData(),
        ).thenAnswer(
          (_) async => imageModel,
        );
        when(
          () => mockImageDataSource2.getImageData(),
        ).thenThrow(
          (_) async => Exception(''),
        );
      },
    );

    test(
      'gets image model data from the data source',
      () async {
        when(
          () => mockImageRepository.dataSources,
        ).thenReturn(
          [
            mockImageDataSource1,
            mockImageDataSource1,
            mockImageDataSource1,
          ],
        );
        when(
          () => mockImageRepository.chooseIndex(),
        ).thenReturn(2);
        when(
          () => mockImageRepository.getImageModel(),
        ).thenAnswer(
          (_) async {
            return mockImageRepository.retry(
              chosenIndex: mockImageRepository.chooseIndex(),
              numberOfRetries: 3,
            );
          },
        );

        final resultImageModel = await mockImageRepository.getImageModel();

        expect(
          resultImageModel,
          isA<ImageModel>()
              .having(
                (imageModel) => imageModel.imageUrl,
                'imageUrl',
                'imageUrl',
              )
              .having(
                (imageModel) => imageModel.author,
                'author',
                'author',
              ),
        );
        verify(
          () => mockImageDataSource1.getImageData(),
        ).called(1);
      },
    );

    test(
      'on error when getting data, gets a image model data from another data source in the list until success, logs every failed attempt',
      () async {
        when(
          () => mockImageRepository.dataSources,
        ).thenReturn(
          [
            mockImageDataSource2,
            mockImageDataSource1,
            mockImageDataSource2,
            mockImageDataSource2,
          ],
        );

        when(
          () => mockImageRepository.chooseIndex(),
        ).thenReturn(2);

        when(
          () => mockImageRepository.getImageModel(),
        ).thenAnswer(
          (_) async {
            return mockImageRepository.retry(
              chosenIndex: mockImageRepository.chooseIndex(),
              numberOfRetries: 4,
            );
          },
        );

        final resultImageModel = await mockImageRepository.getImageModel();

        expect(resultImageModel, imageModel);
        verify(
          () => mockImageDataSource1.getImageData(),
        ).called(1);
        verify(
          () => mockImageDataSource2.getImageData(),
        ).called(
          mockImageRepository.dataSources.length - 1,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          mockImageRepository.dataSources.length - 1,
        );
      },
    );

    test(
      'on error on every data call in the list throws an error, logs every failed attempt',
      () async {
        when(
          () => mockImageRepository.dataSources,
        ).thenReturn(
          [
            mockImageDataSource2,
            mockImageDataSource2,
            mockImageDataSource2,
          ],
        );
        
        when(
          () => mockImageRepository.chooseIndex(),
        ).thenReturn(2);

        when(
          () => mockImageRepository.getImageModel(),
        ).thenAnswer(
          (_) async {
            return mockImageRepository.retry(
              chosenIndex: mockImageRepository.chooseIndex(),
              numberOfRetries: 3,
            );
          },
        );

        expect(
          mockImageRepository.getImageModel,
          throwsException,
        );
        verify(
          () => mockImageDataSource2.getImageData(),
        ).called(
          mockImageRepository.dataSources.length,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          mockImageRepository.dataSources.length,
        );
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';

class MockImageDataSource extends Mock implements ImageDataSource {
  Future<ImageModel?> getImageModel();
}

class MockLogger extends Mock implements Logger {}

main() {
  globalLogger = MockLogger();
  late ImageRepository imageRepository;
  late MockImageDataSource mockImageDataSource1;
  late MockImageDataSource mockImageDataSource2;
  final ImageModel imageModel = ImageModel(
    imageUrl: 'imageUrl',
    author: 'author',
  );

  group('getImageModel', () {
    setUp(() {
      mockImageDataSource1 = MockImageDataSource();
      mockImageDataSource2 = MockImageDataSource();
      imageRepository = ImageRepository();

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
    });

    test(
      'gets image model data from the data source',
      () async {
        imageRepository.dataSources = [
          mockImageDataSource1,
          mockImageDataSource1,
          mockImageDataSource1,
        ];

        when(
          () => mockImageDataSource1.getImageData(),
        ).thenAnswer(
          (_) async => imageModel,
        );

        final resultImageModel = await imageRepository.getImageModel();

        expect(resultImageModel, imageModel);
        verify(
          () => mockImageDataSource1.getImageData(),
        ).called(1);
      },
    );

    test(
      'on error when getting data, gets a image model data from another data source in the list until success, logs every failed attempt',
      () async {
        imageRepository.dataSources = [
          mockImageDataSource2,
          mockImageDataSource1,
          mockImageDataSource2,
          mockImageDataSource2,
        ];

        imageRepository.chosenIndex = 2;

        final resultImageModel = await imageRepository.getImageModel();

        expect(resultImageModel, imageModel);
        verify(
          () => mockImageDataSource1.getImageData(),
        ).called(1);
        verify(
          () => mockImageDataSource2.getImageData(),
        ).called(
          imageRepository.dataSources.length - 1,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          imageRepository.dataSources.length - 1,
        );
      },
    );

    test(
      'on error on every data call in the list throws an error, logs every failed attempt',
      () async {
        imageRepository.dataSources = [
          mockImageDataSource2,
          mockImageDataSource2,
          mockImageDataSource2,
        ];

        expect(
          imageRepository.getImageModel,
          throwsException,
        );
        verify(
          () => mockImageDataSource2.getImageData(),
        ).called(
          imageRepository.dataSources.length,
        );
        verify(
          () => globalLogger.log(any()),
        ).called(
          imageRepository.dataSources.length,
        );
      },
    );
  });
}

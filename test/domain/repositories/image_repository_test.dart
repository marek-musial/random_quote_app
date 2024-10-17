import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';

class MockImageDataSource extends Mock implements ImageDataSource {
  Future<ImageModel?> getImageModel();
}

main() {
  late ImageRepository imageRepository;
  late MockImageDataSource mockImageDataSource1;
  late MockImageDataSource mockImageDataSource2;

  group('getImageModel', () {
    setUp(() {
      mockImageDataSource1 = MockImageDataSource();
      mockImageDataSource2 = MockImageDataSource();
      imageRepository = ImageRepository();
    });

    test(
      'gets image model data from the data source',
      () async {
        imageRepository.dataSources = [
          mockImageDataSource1,
          mockImageDataSource1,
          mockImageDataSource1,
        ];
        final ImageModel imageModel = ImageModel(
          imageUrl: 'imageUrl',
          author: 'author',
        );
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
      'on error when getting data, gets a image model data from another data source in the list',
      () async {
        imageRepository.dataSources = [
          mockImageDataSource1,
          mockImageDataSource1,
          mockImageDataSource2,
        ];
        final ImageModel imageModel = ImageModel(
          imageUrl: 'imageUrl',
          author: 'author',
        );
        when(
          () => mockImageDataSource1.getImageData(),
        ).thenThrow(
          (_) async => Exception(''),
        );
        when(
          () => mockImageDataSource2.getImageData(),
        ).thenAnswer(
          (_) async => imageModel,
        );

        final resultImageModel = await imageRepository.getImageModel();

        expect(resultImageModel, imageModel);
        verify(
          () => mockImageDataSource1.getImageData(),
        ).called(lessThanOrEqualTo(2));
        verify(
          () => mockImageDataSource2.getImageData(),
        ).called(1);
      },
    );
  });
}

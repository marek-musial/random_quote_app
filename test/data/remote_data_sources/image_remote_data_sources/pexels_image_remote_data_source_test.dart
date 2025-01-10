import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/pexels_image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class MockPexelsImageRemoteRetrofitDataSource extends Mock implements PexelsImageRemoteRetrofitDataSource {}

void main() {
  late PexelsImageRemoteDataSource pexelsDataSource;
  late MockPexelsImageRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockPexelsImageRemoteRetrofitDataSource();
      pexelsDataSource = PexelsImageRemoteDataSource();
      pexelsDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('randomPage', () {
    test(
      'return random int within range',
      () {
        expect(
          randomPage,
          inInclusiveRange(1, 8000),
        );
      },
    );
  });

  group('getImageData', () {
    test(
      'should return ImageModel when getImageData is successful',
      () async {
        final pexelsResponse = PexelsResponse.fromJson(
          <String, dynamic>{
            'photos': [
              <String, dynamic>{
                'photographer': 'author',
                'src': <String, dynamic>{
                  'large': 'https://images.pexels.com/photos/exampleLink',
                },
              },
            ],
          },
        );

        when(
          () => mockRetrofitDataSource.getImageData(
            page: any(
              named: 'page',
            ),
            perPage: any(
              named: 'perPage',
            ),
            key: any(
              named: 'key',
            ),
          ),
        ).thenAnswer(
          (_) async => pexelsResponse,
        );

        final result = await pexelsDataSource.getImageData();

        expect(
          result,
          isA<ImageModel>()
              .having(
                (imageModel) => imageModel.imageUrl,
                'imageUrl',
                'https://images.pexels.com/photos/exampleLink',
              )
              .having(
                (imageModel) => imageModel.author,
                'author',
                'author, image provided by Pexels',
              ),
        );
        verify(
          () => mockRetrofitDataSource.getImageData(
            page: any(
              named: 'page',
            ),
            perPage: any(
              named: 'perPage',
            ),
            key: any(
              named: 'key',
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
          () => mockRetrofitDataSource.getImageData(
            page: any(
              named: 'page',
            ),
            perPage: any(
              named: 'perPage',
            ),
            key: any(
              named: 'key',
            ),
          ),
        ).thenThrow(dioError);

        expect(
          () => pexelsDataSource.getImageData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

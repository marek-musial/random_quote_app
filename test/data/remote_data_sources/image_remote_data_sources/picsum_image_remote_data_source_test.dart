import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/picsum_image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class MockPicsumImageRemoteRetrofitDataSource extends Mock implements PicsumImageRemoteRetrofitDataSource {}

void main() {
  late PicsumImageRemoteDataSource picsumDataSource;
  late MockPicsumImageRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockPicsumImageRemoteRetrofitDataSource();
      picsumDataSource = PicsumImageRemoteDataSource();
      picsumDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('PicsumImageRemoteDataSource', () {
    test('instantiates data source with predetermined values', () {
      expect(
        picsumDataSource.title,
        'Picsum',
      );
      expect(
        picsumDataSource.blurb,
        'Lorem Picsum is a service providing easy to use, stylish placeholders.\nCreated by David Marby & Nijiko Yonskai.',
      );
      expect(
        picsumDataSource.link,
        'https://picsum.photos/',
      );
    });
  });

  group('getImageData', () {
    test(
      'should return ImageModel when getImageData is successful',
      () async {
        final picsumResponse = PicsumResponse.fromJson(
          <String, String>{
            'id': 'exampleId',
            'author': 'author',
          },
        );

        when(
          () => mockRetrofitDataSource.getImageData(
            page: any(
              named: 'page',
            ),
            limit: any(
              named: 'limit',
            ),
          ),
        ).thenAnswer(
          (_) async => [picsumResponse],
        );

        final result = await picsumDataSource.getImageData();

        expect(
          result,
          isA<ImageModel>()
              .having(
                (imageModel) => imageModel.imageUrl,
                'imageUrl',
                'https://picsum.photos/id/exampleId/1080',
              )
              .having(
                (imageModel) => imageModel.author,
                'author',
                'author',
              ),
        );
        verify(
          () => mockRetrofitDataSource.getImageData(
            page: any(
              named: 'page',
            ),
            limit: any(
              named: 'limit',
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
            limit: any(
              named: 'limit',
            ),
          ),
        ).thenThrow(dioError);

        expect(
          () => picsumDataSource.getImageData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

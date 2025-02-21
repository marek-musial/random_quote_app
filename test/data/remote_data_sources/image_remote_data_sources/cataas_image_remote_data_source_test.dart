import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/cataas_image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class MockCataasImageRemoteRetrofitDataSource extends Mock implements CataasImageRemoteRetrofitDataSource {}

void main() {
  late CataasImageRemoteDataSource cataasDataSource;
  late MockCataasImageRemoteRetrofitDataSource mockRetrofitDataSource;

  setUp(
    () {
      mockRetrofitDataSource = MockCataasImageRemoteRetrofitDataSource();
      cataasDataSource = CataasImageRemoteDataSource();
      cataasDataSource.dataSource = mockRetrofitDataSource;
    },
  );

  group('getImageData', () {
    test(
      'should return ImageModel when getImageData is successful',
      () async {
        final cataasResponse = CataasResponse.fromJson(
          <String, String>{
            'id': 'abc123',
          },
        );

        when(
          () => mockRetrofitDataSource.getImageData(),
        ).thenAnswer(
          (_) async => cataasResponse,
        );

        final result = await cataasDataSource.getImageData();

        expect(
          result,
          isA<ImageModel>()
              .having(
                (imageModel) => imageModel.imageUrl,
                'imageUrl',
                'https://cataas.com/cat/abc123',
              )
              .having(
                (imageModel) => imageModel.author,
                'author',
                null,
              ),
        );
        verify(
          () => mockRetrofitDataSource.getImageData(),
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
          () => mockRetrofitDataSource.getImageData(),
        ).thenThrow(dioError);

        expect(
          () => cataasDataSource.getImageData(),
          throwsA(
            isA<Exception>(),
          ),
        );
      },
    );
  });
}

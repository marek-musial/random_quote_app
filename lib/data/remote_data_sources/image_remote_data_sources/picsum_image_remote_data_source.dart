import 'dart:math';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:retrofit/retrofit.dart';

part 'picsum_image_remote_data_source.g.dart';
part 'picsum_image_remote_data_source.freezed.dart';

@freezed
class PicsumResponse with _$PicsumResponse {
  factory PicsumResponse({
    required String id,
    required String? author,
  }) = _PicsumResponse;

  factory PicsumResponse.fromJson(Map<String, dynamic> json) => _$PicsumResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://picsum.photos/v2')
abstract class PicsumImageRemoteRetrofitDataSource {
  @factoryMethod
  factory PicsumImageRemoteRetrofitDataSource(
    Dio dio,
  ) = _PicsumImageRemoteRetrofitDataSource;

  @GET('/list')
  Future<List<PicsumResponse>> getImageData({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });
}

class PicsumImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Picsum';
  @override
  final blurb = 'Lorem Picsum is a service providing easy to use, stylish placeholders.\nCreated by David Marby & Nijiko Yonskai.';
  @override
  final link = 'https://picsum.photos/';

  late PicsumImageRemoteRetrofitDataSource dataSource = //R
      PicsumImageRemoteRetrofitDataSource(dioClient.dio);

  @override
  Future<ImageModel?> getImageData() async {
    final randomPage = Random().nextInt(10) + 1;
    try {
      final imageData = await dataSource.getImageData(page: randomPage, limit: 100);
      final photo = imageData[Random().nextInt(imageData.length)];
      final imageModel = ImageModel(
        imageUrl: 'https://picsum.photos/id/${photo.id}/1080',
        author: photo.author,
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Picsum api unknown error');
    }
  }
}

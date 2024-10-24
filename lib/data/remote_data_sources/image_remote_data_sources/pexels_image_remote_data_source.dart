import 'dart:math';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:retrofit/retrofit.dart';

import 'package:random_quote_app/env/env.dart';

part 'pexels_image_remote_data_source.g.dart';
part 'pexels_image_remote_data_source.freezed.dart';

@freezed
class PexelsResponse with _$PexelsResponse {
  factory PexelsResponse({
    required List<PexelsPhoto> photos,
  }) = _PexelsResponse;

  factory PexelsResponse.fromJson(Map<String, dynamic> json) => _$PexelsResponseFromJson(json);
}

@freezed
class PexelsPhoto with _$PexelsPhoto {
  factory PexelsPhoto({
    required String? photographer,
    @JsonKey(name: 'src') required PexelsSizes sizes,
  }) = _PexelsPhoto;

  factory PexelsPhoto.fromJson(Map<String, dynamic> json) => _$PexelsPhotoFromJson(json);
}

@freezed
class PexelsSizes with _$PexelsSizes {
  factory PexelsSizes({
    required String large,
  }) = _PexelsSizes;

  factory PexelsSizes.fromJson(Map<String, dynamic> json) => _$PexelsSizesFromJson(json);
}

final int randomPage = Random().nextInt(8000);

@injectable
@RestApi(baseUrl: 'https://api.pexels.com/v1/')
abstract class PexelsImageRemoteRetrofitDataSource {
  @factoryMethod
  factory PexelsImageRemoteRetrofitDataSource(
    Dio dio,
  ) = _PexelsImageRemoteRetrofitDataSource;

  @GET('/curated/')
  Future<PexelsResponse> getImageData({
    @Query('page') required int page,
    @Query('per_page') required int perPage,
    @Header('Authorization') required String key,
  });
}

class PexelsImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Pexels';
  @override
  final blurb = 'The best free stock photos, royalty free images & videos shared by creators.';
  @override
  final link = 'https://www.pexels.com/api/';

// coverage:ignore-start
  late PexelsImageRemoteRetrofitDataSource dataSource = //R
      PexelsImageRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<ImageModel?> getImageData() async {
    try {
      const int perPage = 1;
      final randomPage = Random().nextInt(8000);
      final imageData = await dataSource.getImageData(
        page: randomPage,
        perPage: perPage,
        key: Env.pexelsApiKey,
      );
      final photo = imageData.photos[Random().nextInt(imageData.photos.length)];

      final imageModel = ImageModel(
        imageUrl: photo.sizes.large,
        author: '${photo.photographer}, image provided by Pexels',
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Pexels api unknown error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:retrofit/retrofit.dart';

part 'cataas_image_remote_data_source.g.dart';
part 'cataas_image_remote_data_source.freezed.dart';

@freezed
class CataasResponse with _$CataasResponse {
  factory CataasResponse({
    @JsonKey(name: '_id') required String id,
  }) = _CataasResponse;

  factory CataasResponse.fromJson(Map<String, dynamic> json) => _$CataasResponseFromJson(json);
}

@injectable
@RestApi(baseUrl: 'https://cataas.com/')
abstract class CataasImageRemoteRetrofitDataSource {
  @factoryMethod
  factory CataasImageRemoteRetrofitDataSource(
    Dio dio,
  ) = _CataasImageRemoteRetrofitDataSource;

  @GET('/cat?json=true')
  Future<CataasResponse> getImageData();
}

class CataasImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Cataas';
  @override
  final blurb = 'Cat as a service (CATAAS) is a REST API to spread peace and love (or not) thanks to cats.\nCreated by Kevin Balicot.';
  @override
  final link = 'https://cataas.com/';

// coverage:ignore-start
  late CataasImageRemoteRetrofitDataSource dataSource = //R
      CataasImageRemoteRetrofitDataSource(dioClient.dio);
// coverage:ignore-end

  @override
  Future<ImageModel?> getImageData() async {
    try {
      final imageData = await dataSource.getImageData();
      final imageId = imageData.id;
      final imageModel = ImageModel(
        imageUrl: 'https://cataas.com/cat/$imageId',
        author: null,
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Cataas api unknown error');
    }
  }
}

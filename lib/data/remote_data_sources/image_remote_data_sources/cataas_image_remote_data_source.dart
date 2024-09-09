import 'package:dio/dio.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class CataasImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Cataas';
  @override
  final blurb = 'Cat as a service (CATAAS) is a REST API to spread peace and love (or not) thanks to cats.\nCreated by Kevin Balicot.';
  @override
  final link = 'https://cataas.com/';

  @override
  Future<ImageModel?> getImageData() async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        'https://cataas.com/cat?json=true',
      );
      final json = response.data;

      if (json == null) {
        return null;
      }

      final id = json['_id'];

      final imageModel = ImageModel(
        imageUrl: 'https://cataas.com/cat/$id',
        author: null,
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

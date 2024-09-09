import 'dart:math';

import 'package:dio/dio.dart';
import 'package:random_quote_app/data/dio_client.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

import 'package:random_quote_app/env/env.dart';

class PexelsImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Pexels';
  @override
  final blurb = 'The best free stock photos, royalty free images & videos shared by creators.';
  @override
  final link = 'https://www.pexels.com/api/';

  @override
  Future<ImageModel?> getImageData() async {
    try {
      const int perPage = 1;
      final randomPage = Random().nextInt(8000);
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        'https://api.pexels.com/v1/curated/?page=$randomPage&per_page=$perPage',
        options: Options(
          headers: {'Authorization': Env.pexelsApiKey},
        ),
      );
      final json = response.data;

      if (json == null) {
        return null;
      }

      final List<dynamic> photos = json['photos'];
      if (photos.isEmpty) {
        return null;
      }
      final Map<String, dynamic> photo = photos[Random().nextInt(perPage)];

      final imageModel = ImageModel(
        imageUrl: photo['src']['large'],
        author: '${photo['photographer']}, image provided by Pexels',
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

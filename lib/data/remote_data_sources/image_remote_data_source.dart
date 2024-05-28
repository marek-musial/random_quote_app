import 'dart:math';

import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

abstract class ImageDataSource {
  Future<ImageModel?> getImageData();
}

class ShibeImageRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
    try {
      final response = await Dio().get<List<dynamic>>(
        'http://shibe.online/api/shibes?',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      final imageModel = ImageModel(
        imageUrl: json[0],
        author: null,
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class PicsumImageRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
    final randomPage = Random().nextInt(10 + 1);
    try {
      final response = await Dio().get<List<dynamic>?>(
        'https://picsum.photos/v2/list?page=$randomPage&limit=100',
      );
      final jsons = response.data;

      if (jsons == null || jsons.isEmpty) {
        return null;
      }

      final Map<String, dynamic> json = jsons[Random().nextInt(
        response.data!.length,
      )];
      final id = json['id'];

      final imageModel = ImageModel(
        imageUrl: 'https://picsum.photos/id/$id/1080',
        author: json['author'],
      );
      return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class CataasImageRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
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

class PexelsImageRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
    try {
      const int perPage = 1;
      final randomPage = Random().nextInt(8000);
      final response = await Dio().get<Map<String, dynamic>>(
        'https://api.pexels.com/v1/curated/?page=$randomPage&per_page=$perPage',
        options: Options(
          headers: {'Authorization': 'qQNv5hJlBHeKv7n5NWRMTQSRq8hp74ocky4bby42cXGl3HJTSh8yYopt'},
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

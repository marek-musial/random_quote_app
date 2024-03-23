import 'dart:math';

import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

abstract class ImageDataSource {
  Future<ImageModel?> getImageData();
}

class FirstRemoteDataSource implements ImageDataSource {
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

class SecondRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
    final randomID = Random().nextInt(1084 + 1);
    try {
    final response = await Dio().get<Map<String, dynamic>?>(
      'https://picsum.photos/id/$randomID/info',
    );
    final json = response.data;

    if (json == null) {
      return null;
    }

    final imageModel = ImageModel(
      imageUrl: 'https://picsum.photos/id/$randomID/1080',
      author: json['author'],
    );
    return imageModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

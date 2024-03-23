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

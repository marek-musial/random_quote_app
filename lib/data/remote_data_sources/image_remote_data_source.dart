import 'dart:math';

import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

import 'package:random_quote_app/env/env.dart';

abstract class ImageDataSource {
  ImageDataSource({
    this.title,
    this.blurb,
    this.link,
  });
  final String? title;
  final String? blurb;
  final String? link;
  Future<ImageModel?> getImageData();
}

class ShibeImageRemoteDataSource implements ImageDataSource {
  @override
  final title = 'Shibe.online';
  @override
  final blurb = 'The shiba inu api';
  @override
  final link = 'https://shibe.online/';

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
  final title = 'Picsum';
  @override
  final blurb = 'Lorem Picsum is a service providing easy to use, stylish placeholders.\nCreated by David Marby & Nijiko Yonskai.';
  @override
  final link = 'https://picsum.photos/';

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
  final title = 'Cataas';
  @override
  final blurb = 'Cat as a service (CATAAS) is a REST API to spread peace and love (or not) thanks to cats.\nCreated by Kevin Balicot.';
  @override
  final link = 'https://cataas.com/';

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
      final response = await Dio().get<Map<String, dynamic>>(
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

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

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

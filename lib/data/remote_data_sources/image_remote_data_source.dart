import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

abstract class ImageDataSource {
  Future<ImageModel?> getImageData();
}

class FirstRemoteDataSource implements ImageDataSource {
  @override
  Future<ImageModel?> getImageData() async {
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
  }
}

import 'package:dio/dio.dart';

class ImageRemoteDataSource {
  Future<List<dynamic>?> getImageData() async {
    final response = await Dio().get<List<dynamic>>(
      'http://shibe.online/api/shibes?',
    );
    return response.data;
  }
}

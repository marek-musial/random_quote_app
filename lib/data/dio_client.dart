import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal(Dio());

  final Dio _dio;

  DioClient._internal(this._dio) {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  factory DioClient() {
    return _instance;
  }

  Dio get dio => _dio;
}

final DioClient dioClient = DioClient();

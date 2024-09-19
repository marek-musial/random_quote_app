import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:random_quote_app/core/injection_container.dart';

@singleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  Dio get dio => _dio;
}

final dioClient = getIt<DioClient>();

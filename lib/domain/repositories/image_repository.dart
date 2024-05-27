import 'dart:math';

import 'package:random_quote_app/data/remote_data_sources/image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class ImageRepository {
  ImageRepository();

  final List<ImageDataSource> dataSources = [
    // ShibeImageRemoteDataSource(),
    PicsumImageRemoteDataSource(),
  ];

  Future<ImageModel?> getImageModel() async {
    final randomDataSource = dataSources[Random().nextInt(dataSources.length)];

    return await randomDataSource.getImageData();
  }
}

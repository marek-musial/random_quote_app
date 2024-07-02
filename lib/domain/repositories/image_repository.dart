import 'dart:math';

import 'package:random_quote_app/data/remote_data_sources/image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

final List<ImageDataSource> imageDataSources = [
  // ShibeImageRemoteDataSource(),
  PicsumImageRemoteDataSource(),
  CataasImageRemoteDataSource(),
  PexelsImageRemoteDataSource(),
];

class ImageRepository {
  ImageRepository();

  Future<ImageModel?> getImageModel() async {
    final randomDataSource = imageDataSources[Random().nextInt(imageDataSources.length)];

    return await randomDataSource.getImageData();
  }
}

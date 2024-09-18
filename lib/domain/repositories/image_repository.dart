import 'dart:math';
import 'dart:developer' as dev;

import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/cataas_image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/pexels_image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/picsum_image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

final List<ImageDataSource> imageDataSources = [
  PicsumImageRemoteDataSource(),
  CataasImageRemoteDataSource(),
  PexelsImageRemoteDataSource(),
];

class ImageRepository {
  ImageRepository();

  Future<ImageModel?> getImageModel() async {
    final int chosenIndex = Random().nextInt(imageDataSources.length);
    try {
      final randomDataSource = imageDataSources[chosenIndex];
      return await randomDataSource.getImageData();
    } catch (e) {
      dev.log('[Time: ${DateTime.now().toString()}] $e');
      int otherIndex;
      if (chosenIndex < imageDataSources.length - 1) {
        otherIndex = chosenIndex + 1;
      } else {
        otherIndex = chosenIndex - 1;
      }
      final randomDataSource = imageDataSources[otherIndex];
      return await randomDataSource.getImageData();
    }
  }
}

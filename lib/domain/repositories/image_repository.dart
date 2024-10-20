import 'dart:math';
import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
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

@injectable
class ImageRepository {
  ImageRepository();
  List<ImageDataSource> dataSources = imageDataSources;

  Future<ImageModel?> getImageModel() async {
    final int chosenIndex = Random().nextInt(dataSources.length);
    try {
      final randomDataSource = dataSources[chosenIndex];
      return await randomDataSource.getImageData();
    } catch (e) {
      dev.log('[Time: ${DateTime.now().toString()}] $e');
      int otherIndex;
      if (chosenIndex < dataSources.length - 1) {
        otherIndex = chosenIndex + 1;
      } else {
        otherIndex = 0;
      }
      final randomDataSource = dataSources[otherIndex];
      return await randomDataSource.getImageData();
    }
  }
}

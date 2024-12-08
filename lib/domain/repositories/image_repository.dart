import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:random_quote_app/core/logger.dart';
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
  late int chosenIndex;
  int chooseIndex() {
    return Random().nextInt(dataSources.length);
  }

  Future<ImageModel?> getImageModel() async {
    int retries = dataSources.length;
    chosenIndex = chooseIndex();
    try {
      return await retry(
        chosenIndex: chosenIndex,
        numberOfRetries: retries,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ImageModel?> retry<T>({
    required int chosenIndex,
    required int numberOfRetries,
  }) async {
    int retries = numberOfRetries;

    while (retries-- > 0) {
      try {
        final randomDataSource = dataSources[chosenIndex];
        return await randomDataSource.getImageData();
      } catch (e) {
        globalLogger.log('$e');
        if (chosenIndex < dataSources.length - 1) {
          chosenIndex++;
        } else {
          chosenIndex = 0;
        }
      }
    }
    {
      throw ('Error while getting image. Check your network connection.');
    }
  }
}

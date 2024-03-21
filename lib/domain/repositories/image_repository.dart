import 'package:random_quote_app/data/remote_data_sources/image_remote_data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

class ImageRepository {
  ImageRepository(this._imageRemoteDataSource);

  final ImageRemoteDataSource _imageRemoteDataSource;

  Future<ImageModel?> getImageModel() async {
    final json = await _imageRemoteDataSource.getImageData();

    if (json == null) {
      return null;
    }

    return ImageModel.fromJson(json);
  }
}

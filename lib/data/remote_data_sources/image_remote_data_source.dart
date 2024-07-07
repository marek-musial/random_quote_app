import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/image_model.dart';

abstract class ImageDataSource extends DataSource {
  Future<ImageModel?> getImageData();
}

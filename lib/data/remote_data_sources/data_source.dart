import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class DataSource {
  DataSource({
    this.title,
    this.blurb,
    this.link,
  });
  final String? title;
  final String? blurb;
  final String? link;
}

abstract class ImageDataSource extends DataSource {
  Future<ImageModel?> getImageData();
}

abstract class QuoteDataSource extends DataSource {
  Future<QuoteModel?> getQuoteData();
}

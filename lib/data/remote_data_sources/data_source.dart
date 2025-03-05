import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

class DataSource {
  DataSource({
    String? blurb,
    String? link,
  }) {
    try {
      isEnabled = SharedPreferencesService.getIsEnabled(title);
    } catch (e) {
      isEnabled = true;
    }
  }
  late bool isEnabled;

  String get title => '';
  String? get blurb => null;
  String? get link => null;
}

abstract class ImageDataSource extends DataSource {
  Future<ImageModel?> getImageData();
}

abstract class QuoteDataSource extends DataSource {
  Future<QuoteModel?> getQuoteData();
}

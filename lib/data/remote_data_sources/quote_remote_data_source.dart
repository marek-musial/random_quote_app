import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

abstract class QuoteDataSource extends DataSource {
  Future<QuoteModel?> getQuoteData();
}

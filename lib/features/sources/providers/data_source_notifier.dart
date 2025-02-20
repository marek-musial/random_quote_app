import 'package:flutter/foundation.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';

class DataSourceNotifier extends ChangeNotifier {
  final _dataSourcesMap = getIt<Map<String, DataSource>>();
  
  int enabledCount<T extends DataSource>() {
    return _dataSourcesMap.values.where((ds) => ds is T && ds.isEnabled).length;
  }

  Future<void> toggleDataSource(String key) async {
    final dataSource = _dataSourcesMap[key];
    if (dataSource == null) return;

    bool isLastImageSource = dataSource is ImageDataSource && //R
        enabledCount<ImageDataSource>() <= 1 &&
        dataSource.isEnabled;
    bool isLastQuoteSource = dataSource is QuoteDataSource && //R
        enabledCount<QuoteDataSource>() <= 1 &&
        dataSource.isEnabled;

    if (isLastImageSource || isLastQuoteSource) {
      globalLogger.log(
        'Source ${dataSource.title} not disabled',
      );
      return;
    }

    dataSource.isEnabled = !dataSource.isEnabled;
    notifyListeners();

    await SharedPreferencesService.setIsEnabledFromMap(
      _dataSourcesMap,
      dataSource.title,
    );
  }
}

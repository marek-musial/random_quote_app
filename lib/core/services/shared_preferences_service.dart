import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferencesWithCache prefs;
  static late SharedPreferencesWithCacheOptions prefOptions;
  static bool isInitialized = false;

  static Future<void> init({SharedPreferencesWithCache? p}) async {
    if (!isInitialized) {
      p == null ? prefOptions = SharedPreferencesWithCacheOptions() : {};
      prefs = p ??
          await SharedPreferencesWithCache.create(
            cacheOptions: prefOptions,
          );
      isInitialized = true;
    }
  }

  // static void getAllIsEnabled() {
  //   for (var dataSource in _dataSources) {
  //     bool isEnabled = getIsEnabled(dataSource.title);
  //     dataSource.isEnabled = isEnabled;
  //   }
  // }

  static bool getIsEnabled(String key) {
    bool result = prefs.getBool(key) ?? true;
    globalLogger.log(
      'Source $key ${result ? 'enabled' : 'disabled'}',
    );
    return result;
  }

  static Future<void> setIsEnabledFromMap(
    Map<String, DataSource> dataSourcesMap,
    String key,
  ) async {
    for (DataSource dataSource in dataSourcesMap.values.where(
      (ds) => ds.title == key,
    )) {
      await setIsEnabled(dataSource.title, dataSource.isEnabled);
    }
  }

  static Future<void> setIsEnabled(String key, bool value) async {
    await prefs.setBool(key, value);
    globalLogger.log(
      'Set source $key to ${value ? 'enabled' : 'disabled'}',
    );
  }
}

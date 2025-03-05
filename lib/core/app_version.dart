import 'package:package_info_plus/package_info_plus.dart';
import 'package:random_quote_app/core/logger.dart';

String appVersion = '';

Future<void> getAppVersion({String? build}) async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = build == null //R
        ? packageInfo.version
        : packageInfo.version + build;
  } catch (e) {
    globalLogger.log(e.toString());
  }
}

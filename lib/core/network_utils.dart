import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:random_quote_app/core/logger.dart';

class NetworkUtils {
  static Connectivity connectivity = Connectivity();

  static Future<bool> checkConnectivity() async {
    try {
      final connectivityResults = await connectivity.checkConnectivity();

      final isConnected = connectivityResults.isNotEmpty && //R
          !connectivityResults.contains(ConnectivityResult.none);

      globalLogger.log('Connection status: $isConnected');
      return isConnected;
    } catch (e) {
      globalLogger.log('Error checking connectivity: $e');
      return false;
    }
  }
}

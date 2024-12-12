import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/network_utils.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockConnectivity mockConnectivity;

  group('NetworkUtils', () {
    setUp(
      () {
        mockConnectivity = MockConnectivity();
        NetworkUtils.connectivity = mockConnectivity;
        globalLogger = MockLogger();
      },
    );

    test(
      'NetworkUtils.checkConnectivity returns true when connected',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );

        final isConnected = await NetworkUtils.checkConnectivity();

        expect(isConnected, true);
      },
    );

    test(
      'NetworkUtils.checkConnectivity returns false when not connected',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer(
          (_) async => [ConnectivityResult.none],
        );

        final isConnected = await NetworkUtils.checkConnectivity();

        expect(isConnected, false);
      },
    );

    test(
      'NetworkUtils.checkConnectivity throws an error and logs it',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenThrow(
          'network error',
        );

        final isConnected = await NetworkUtils.checkConnectivity();

        expect(isConnected, false);
        verify(
          () => globalLogger.log('Error checking connectivity: network error'),
        ).called(1);
      },
    );
  });
}

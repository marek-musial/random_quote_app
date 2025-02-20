import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferencesWithCache extends Mock implements SharedPreferencesWithCache {}

class MockDataSource extends Mock implements DataSource {}

class MockDataSource1 extends Mock implements DataSource {
  @override
  String get title => 'title1';
  @override
  bool get isEnabled => true;
}

class MockDataSource2 extends Mock implements DataSource {
  @override
  String get title => 'title2';
  @override
  bool get isEnabled => false;
}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockSharedPreferencesWithCache mockPrefs;
  late List<DataSource> mockDataSources;
  final dataSource1 = MockDataSource1();
  final dataSource2 = MockDataSource2();
  late Map<String, DataSource> mockDataSourcesMap;
  late MockLogger mockLogger = MockLogger();

  setUp(
    () {
      mockPrefs = MockSharedPreferencesWithCache();
      mockDataSources = [
        dataSource1,
        dataSource2,
      ];

      getIt.registerSingleton<List<DataSource>>(mockDataSources);

      globalLogger = mockLogger;
    },
  );

  tearDown(
    () {
      getIt.reset();
      SharedPreferencesService.isInitialized = false;
    },
  );

  group('SharedPreferencesService', () {
    test(
      'initializes SharedPreferencesWithCache',
      () async {
        when(() => mockPrefs.getBool(any())).thenReturn(null);
        expect(SharedPreferencesService.isInitialized, false);

        await SharedPreferencesService.init(p: mockPrefs);

        expect(SharedPreferencesService.isInitialized, true);
        expect(SharedPreferencesService.prefs, mockPrefs);
      },
    );
  });

  group('getIsEnabled', () {
    setUp(
      () async {
        await SharedPreferencesService.init(p: mockPrefs);
      },
    );

    test(
      'returns correct value and logs appropriate message',
      () {
        when(() => mockPrefs.getBool('test_key')).thenReturn(false);

        final result = SharedPreferencesService.getIsEnabled('test_key');
        expect(result, false);

        verify(
          () => mockLogger.log(
            'Source test_key disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(
          mockLogger,
        );
      },
    );

    test(
      'returns true if key is not found and logs appropriate message',
      () {
        when(() => mockPrefs.getBool('unknown_key')).thenReturn(null);

        final result = SharedPreferencesService.getIsEnabled('unknown_key');
        expect(result, true);

        verify(
          () => mockLogger.log(
            'Source unknown_key enabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(
          mockLogger,
        );
      },
    );
  });

  group('setIsEnabled', () {
    setUp(
      () async {
        await SharedPreferencesService.init(p: mockPrefs);
      },
    );

    test(
      'sets value and logs appropriate message',
      () async {
        when(() => mockPrefs.setBool('test_key', true)).thenAnswer((_) async => true);

        await SharedPreferencesService.setIsEnabled('test_key', true);

        verify(() => mockPrefs.setBool('test_key', true)).called(1);

        verify(
          () => mockLogger.log(
            'Set source test_key to enabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(
          mockLogger,
        );
      },
    );
  });

  group('setIsEnabledFromMap', () {
    setUp(
      () async {
        mockDataSourcesMap = {
          for (var ds in mockDataSources) (ds).title: ds,
        };

        getIt.registerSingleton<Map<String, DataSource>>(mockDataSourcesMap);

        await SharedPreferencesService.init(p: mockPrefs);
      },
    );

    test(
      'updates relevant DataSource and logs appropriate message',
      () async {
        final fakeStorage = <String, bool>{};

        when(() => mockPrefs.setBool(any(), any())).thenAnswer((invocation) async {
          final key = invocation.positionalArguments[0] as String;
          final value = invocation.positionalArguments[1] as bool;
          fakeStorage[key] = value;
        });

        when(() => mockPrefs.getBool(any())).thenAnswer((invocation) {
          final key = invocation.positionalArguments[0] as String;
          return fakeStorage[key];
        });

        await SharedPreferencesService.setIsEnabledFromMap(mockDataSourcesMap, 'title2');

        verify(() => mockPrefs.setBool('title2', false)).called(1);

        expect(fakeStorage['title2'], false);
        expect(mockPrefs.getBool('title2'), false);
        verify(() => mockPrefs.getBool('title2')).called(1);

        verify(
          () => mockLogger.log(
            'Set source title2 to disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(
          mockLogger,
        );
      },
    );
  });
}

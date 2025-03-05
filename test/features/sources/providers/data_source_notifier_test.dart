import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/features/sources/providers/data_source_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeImageDataSource1 extends Fake implements ImageDataSource {
  bool _isEnabled = true;
  @override
  String get title => 'ImageSource1';
  @override
  bool get isEnabled => _isEnabled;
  @override
  set isEnabled(bool value) => _isEnabled = value;
}

class FakeImageDataSource2 extends Fake implements ImageDataSource {
  bool _isEnabled = false;
  @override
  String get title => 'ImageSource2';
  @override
  bool get isEnabled => _isEnabled;
  @override
  set isEnabled(bool value) => _isEnabled = value;
}

class FakeQuoteDataSource1 extends Fake implements QuoteDataSource {
  bool _isEnabled = true;
  @override
  String get title => 'QuoteSource1';
  @override
  bool get isEnabled => _isEnabled;
  @override
  set isEnabled(bool value) => _isEnabled = value;
}

class FakeQuoteDataSource2 extends Fake implements QuoteDataSource {
  bool _isEnabled = false;
  @override
  String get title => 'QuoteSource2';
  @override
  bool get isEnabled => _isEnabled;
  @override
  set isEnabled(bool value) => _isEnabled = value;
}

class MockLogger extends Mock implements Logger {}

class MockSharedPreferencesService extends Mock implements SharedPreferencesService {}

class MockSharedPreferencesWithCache extends Mock implements SharedPreferencesWithCache {}

void main() {
  late DataSourceNotifier notifier;
  late FakeImageDataSource1 imageDataSource1;
  late FakeImageDataSource2 imageDataSource2;
  late FakeQuoteDataSource1 quoteDataSource1;
  late FakeQuoteDataSource2 quoteDataSource2;
  late List<DataSource> mockDataSources;
  late Map<String, DataSource> mockDataSourcesMap;
  late MockLogger mockLogger;
  late MockSharedPreferencesWithCache mockPrefs;

  setUp(() async {
    imageDataSource1 = FakeImageDataSource1();
    imageDataSource2 = FakeImageDataSource2();
    quoteDataSource1 = FakeQuoteDataSource1();
    quoteDataSource2 = FakeQuoteDataSource2();
    mockDataSources = [
      imageDataSource1,
      imageDataSource2,
      quoteDataSource1,
      quoteDataSource2,
    ];
    getIt.registerSingleton<List<DataSource>>(mockDataSources);
    mockDataSourcesMap = {
      for (var ds in mockDataSources) (ds).title: ds,
    };
    getIt.registerSingleton<Map<String, DataSource>>(mockDataSourcesMap);

    mockPrefs = MockSharedPreferencesWithCache();
    await SharedPreferencesService.init(p: mockPrefs);

    notifier = DataSourceNotifier();

    mockLogger = MockLogger();
    globalLogger = mockLogger;
  });

  tearDown(
    () async {
      await getIt.reset();
      SharedPreferencesService.isInitialized = false;
    },
  );

  group('enabledCount', () {
    test(
      'returns the amount of enabled data sources of the passed type',
      () {
        final result = notifier.enabledCount<ImageDataSource>();

        expect(
          result,
          mockDataSources
              .where(
                (ds) => ds is ImageDataSource && ds.isEnabled,
              )
              .length,
        );
      },
    );
  });

  group(
    'toggleDataSource',
    () {
      late Map<String, bool> fakeStorage;

      setUp(() async {
        fakeStorage = {for (var ds in mockDataSources) (ds).title: ds.isEnabled};

        when(() => mockPrefs.setBool(any(), any())).thenAnswer(
          (invocation) async {
            String key = invocation.positionalArguments[0] as String;
            bool value = invocation.positionalArguments[1] as bool;
            fakeStorage[key] = value;
          },
        );

        when(() => mockPrefs.getBool(any())).thenAnswer(
          (invocation) {
            String key = invocation.positionalArguments[0] as String;
            return fakeStorage[key];
          },
        );
      });

      tearDown(() async {
        await getIt.reset();
      });

      test('toggles the image data source when not the last enabled one', () async {
        await SharedPreferencesService.setIsEnabled('ImageSource2', true);
        verify(
          () => mockLogger.log(
            'Set source ImageSource2 to enabled',
          ),
        ).called(1);
        imageDataSource1._isEnabled = true;
        imageDataSource2._isEnabled = true;
        expect(fakeStorage['ImageSource1'], true);
        expect(fakeStorage['ImageSource2'], true);

        await notifier.toggleDataSource('ImageSource1');

        expect(fakeStorage['ImageSource1'], false);

        verify(
          () => mockLogger.log(
            'Set source ImageSource1 to disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLogger);
        verify(() => mockPrefs.setBool('ImageSource1', false)).called(1);
      });

      test('does not toggle image data source when it is the last enabled one', () async {
        expect(fakeStorage['ImageSource1'], true);
        expect(fakeStorage['ImageSource2'], false);

        await notifier.toggleDataSource('ImageSource1');

        expect(fakeStorage['ImageSource1'], true);

        verify(
          () => mockLogger.log(
            'Source ImageSource1 not disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLogger);
        verifyNever(() => mockPrefs.setBool('ImageSource1', false));
      });

      test('toggles the quote data source when not the last enabled one', () async {
        await SharedPreferencesService.setIsEnabled('QuoteSource2', true);
        verify(
          () => mockLogger.log(
            'Set source QuoteSource2 to enabled',
          ),
        ).called(1);
        quoteDataSource1._isEnabled = true;
        quoteDataSource2._isEnabled = true;
        expect(fakeStorage['QuoteSource1'], true);
        expect(fakeStorage['QuoteSource2'], true);

        await notifier.toggleDataSource('QuoteSource1');

        expect(fakeStorage['QuoteSource1'], false);

        verify(
          () => mockLogger.log(
            'Set source QuoteSource1 to disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLogger);
        verify(() => mockPrefs.setBool('QuoteSource1', false)).called(1);
      });

      test('does not toggle quote data source when it is the last enabled one', () async {
        expect(fakeStorage['QuoteSource1'], true);
        expect(fakeStorage['QuoteSource2'], false);

        await notifier.toggleDataSource('QuoteSource1');

        expect(fakeStorage['QuoteSource1'], true);

        verify(
          () => mockLogger.log(
            'Source QuoteSource1 not disabled',
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLogger);
        verifyNever(() => mockPrefs.setBool('QuoteSource1', false));
      });
    },
  );
}

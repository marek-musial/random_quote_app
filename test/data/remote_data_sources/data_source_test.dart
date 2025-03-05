import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/shared_preferences_service.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDataSource extends DataSource {
  @override
  String get title => 'Sample title';
  @override
  String? get blurb => 'This is a sample blurb';
  @override
  String? get link => 'https://example.com';
}

class MockLogger extends Mock implements Logger {}

class MockSharedPreferencesWithCache extends Mock implements SharedPreferencesWithCache {}

void main() {
  late MockLogger mockLogger = MockLogger();

  group('DataSource', () {
    setUp(
      () {
        mockLogger = MockLogger();
        globalLogger = mockLogger;
      },
    );

    test(
      'is succesfully instantiated with default values',
      () {
        final dataSource = DataSource();

        expect(dataSource.title, isEmpty);
        expect(dataSource.blurb, isNull);
        expect(dataSource.link, isNull);
        expect(dataSource.isEnabled, isTrue);

        verifyZeroInteractions(mockLogger);
      },
    );

    test(
      'can be instantiated with valid values',
      () async {
        await SharedPreferencesService.init(p: MockSharedPreferencesWithCache());

        final mockDataSource = MockDataSource();

        expect(mockDataSource.title, 'Sample title');
        expect(mockDataSource.blurb, 'This is a sample blurb');
        expect(mockDataSource.link, 'https://example.com');
        expect(mockDataSource.isEnabled, isTrue);

        verify(() => mockLogger.log('Source Sample title enabled')).called(1);
      },
    );
  });
}

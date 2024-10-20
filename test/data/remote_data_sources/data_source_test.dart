import 'package:flutter_test/flutter_test.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';

void main() {
  group('DataSource', () {
    test(
      'can be instantiated with valid values',
      () {
        final dataSource = DataSource(
          title: 'Sample Title',
          blurb: 'This is a sample blurb',
          link: 'https://example.com',
        );

        expect(dataSource.title, 'Sample Title');
        expect(dataSource.blurb, 'This is a sample blurb');
        expect(dataSource.link, 'https://example.com');
      },
    );

    test(
      'can be instantiated with null values',
      () {
        final dataSource = DataSource(
          title: null,
          blurb: null,
          link: null,
        );

        expect(dataSource.title, isNull);
        expect(dataSource.blurb, isNull);
        expect(dataSource.link, isNull);
      },
    );
  });
}

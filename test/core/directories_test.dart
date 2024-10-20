import 'dart:io' show Directory, File;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_quote_app/core/directories.dart';
import 'package:path/path.dart' as path;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('initializeTempDirectory', () {
    setUp(
      () {
        const channel = MethodChannel(
          'plugins.flutter.io/path_provider',
        );
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          channel,
          (final MethodCall methodCall) async => 'mock/path',
        );
      },
    );

    test(
      'gets the directory and logs a message',
      () async {
        final String? uninitializedDir = tempDirectoryPath;
        await initializeTempDirectory();
        final String? initializedDir = tempDirectoryPath;

        expect(uninitializedDir, null);
        expect(initializedDir, 'mock/path');
      },
    );
  });

  group('cleanDirectory', () {
    late Directory tempDirectory;
    late String tempDirectoryPath;

    setUp(
      () async {
        tempDirectory = await Directory.systemTemp.createTemp('test_temp_dir');
        tempDirectoryPath = tempDirectory.path;
        File(path.join(tempDirectoryPath, 'test_file.txt')).createSync();
        Directory(path.join(tempDirectoryPath, 'test_sub_dir')).createSync();
        File(path.join(tempDirectoryPath, 'test_sub_dir', 'nested_file.txt')).createSync();
      },
    );

    tearDown(
      () async {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      },
    );

    test(
      'successfully cleans all files and directories, but keeps the main directory',
      () async {
        expect(
          File(
            path.join(
              tempDirectoryPath,
              'test_file.txt',
            ),
          ).existsSync(),
          isTrue,
        );
        expect(
          Directory(
            path.join(
              tempDirectoryPath,
              'test_sub_dir',
            ),
          ).existsSync(),
          isTrue,
        );
        expect(
          File(
            path.join(
              tempDirectoryPath,
              'test_sub_dir',
              'nested_file.txt',
            ),
          ).existsSync(),
          isTrue,
        );

        cleanDirectory(tempDirectoryPath);

        expect(
          Directory(tempDirectoryPath).existsSync(),
          isTrue,
        );
        expect(
            File(
              path.join(
                tempDirectoryPath,
                'test_file.txt',
              ),
            ).existsSync(),
            isFalse);
        expect(
          Directory(
            path.join(
              tempDirectoryPath,
              'test_sub_dir',
            ),
          ).existsSync(),
          isFalse,
        );
      },
    );
  });
}

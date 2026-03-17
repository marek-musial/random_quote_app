import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/logger.dart';

class GalWrapper {
  Future<void> putImageBytes(
    Uint8List bytes, {
    required String name,
  }) {
    return Gal.putImageBytes(
      bytes,
      name: name,
    );
  }
}

class SharePlusWrapper {
  Future<ShareResult> shareXFiles(
    String imageTempUri,
  ) {
    return Share.shareXFiles(
      [XFile(imageTempUri)],
    );
  }
}

class ImageCaptureService {
  final GalWrapper galWrapper;
  final SharePlusWrapper sharePlusWrapper;
  late String timestamp;
  double imageScale = 1.0;

  ImageCaptureService({
    GalWrapper? galWrapper,
    SharePlusWrapper? sharePlusWrapper,
  })  : galWrapper = galWrapper ?? GalWrapper(),
        sharePlusWrapper = sharePlusWrapper ?? SharePlusWrapper();

  Future<void> capturePng(
    Uint8List bytes, {
    String? fileName,
    double? targetImageDimension,
  }) async {
    if (fileName == null || fileName.isEmpty) {
      timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    }
    await galWrapper.putImageBytes(
      bytes,
      name: fileName ?? 'image_$timestamp',
    );
    globalLogger.log(
      'Saved image name: ${fileName ?? 'image_$timestamp'}',
    );
  }

  Future<void> sharePng(
    Uint8List bytes, {
    String? fileName,
    double? targetImageDimension,
  }) async {
    if (fileName == null || fileName.isEmpty) {
      timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    }
    fileName = fileName ?? 'image_$timestamp';
    final String imageTempUri = '$tempDirectoryPath/$fileName.png';
    final File imageFile = await File(
      imageTempUri,
    ).create();
    imageFile.writeAsBytesSync(bytes);
    final result = await sharePlusWrapper.shareXFiles(
      imageTempUri,
    );
    if (result.status == ShareResultStatus.success) {
      globalLogger.log(
        'Image $fileName shared successfully',
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      globalLogger.log(
        'Image $fileName sharing dismissed',
      );
    } else {
      globalLogger.log(
        'An error occured with share result status ${result.status.toString()}',
      );
    }
  }
}

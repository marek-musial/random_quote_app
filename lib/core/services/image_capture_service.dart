import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

import 'package:random_quote_app/core/directories.dart';
import 'package:random_quote_app/core/logger.dart';

class GalWrapper {
  Future<void> putImageBytes(
    Uint8List pngBytes, {
    required String name,
  }) {
    return Gal.putImageBytes(
      pngBytes,
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
    RenderRepaintBoundary boundary, {
    String? fileName,
    double? targetImageDimension,
  }) async {
    final boundaryHeight = boundary.size.height;
    if (targetImageDimension != null) {
      imageScale = targetImageDimension / boundaryHeight;
    }
    final ui.Image image = await boundary.toImage(
      pixelRatio: imageScale,
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    if (fileName == null || fileName.isEmpty) {
      timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    }
    await galWrapper.putImageBytes(
      pngBytes,
      name: fileName ?? 'image_$timestamp',
    );
    globalLogger.log(
      'Saved image name: ${fileName ?? 'image_$timestamp'}',
    );
    globalLogger.log(
      'Saved image width: ${image.width}, saved image height: ${image.height}',
    );
  }

  Future<void> sharePng(
    RenderRepaintBoundary boundary, {
    String? fileName,
    double? targetImageDimension,
  }) async {
    final boundaryHeight = boundary.size.height;
    if (targetImageDimension != null) {
      imageScale = targetImageDimension / boundaryHeight;
    }
    final ui.Image image = await boundary.toImage(
      pixelRatio: imageScale,
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    if (fileName == null || fileName.isEmpty) {
      timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    }
    final String imageTempUri = '$tempDirectoryPath/${fileName ?? 'image_$timestamp'}.png';
    final File imageFile = await File(
      imageTempUri,
    ).create();
    imageFile.writeAsBytesSync(pngBytes);
    final result = await sharePlusWrapper.shareXFiles(
      imageTempUri,
    );
    if (result.status == ShareResultStatus.success) {
      globalLogger.log(
        'Shared image width: ${image.width}, saved image height: ${image.height}',
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      globalLogger.log(
        'Image sharing dismissed',
      );
    } else {
      globalLogger.log(
        'An error occured with share result status ${result.status.toString()}',
      );
    }
  }
}

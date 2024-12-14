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

class ImageCaptureService {
  final GalWrapper wrapper;

  ImageCaptureService({
    GalWrapper? wrapper,
  }) : wrapper = wrapper ?? GalWrapper();

  Future<void> capturePng(RenderRepaintBoundary boundary) async {
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    String timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    await wrapper.putImageBytes(
      pngBytes,
      name: 'image_$timestamp',
    );
    globalLogger.log(
      'Saved image width: ${image.width}, saved image height: ${image.height}',
    );
  }

  Future<void> sharePng(RenderRepaintBoundary boundary) async {
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    String timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    final String imageTempUri = '$tempDirectoryPath/image_$timestamp.png';
    final File imageFile = await File(
      imageTempUri,
    ).create();
    imageFile.writeAsBytesSync(pngBytes);
    final result = await Share.shareXFiles(
      [XFile(imageTempUri)],
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

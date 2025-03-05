import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/services/image_capture_service.dart';

part 'image_dialog_state.dart';
part 'image_dialog_cubit.freezed.dart';

@injectable
class ImageDialogCubit extends Cubit<ImageDialogState> {
  ImageDialogCubit() : super(ImageDialogState());

  Logger logger = globalLogger;
  ImageCaptureService imageCaptureService = ImageCaptureService();

  Future<void> updateFileSize(
    RenderRepaintBoundary boundary,
    int targetDimension,
  ) async {
    final imageFileScaleFactor = targetDimension / boundary.size.width;
    final ui.Image image = await boundary.toImage(
      pixelRatio: imageFileScaleFactor,
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    if (byteData != null) {
      final imageFileSize = byteData.lengthInBytes;
      final imageFileSizeInKB = (imageFileSize / 1024);
      final imageFileSizeInMB = (imageFileSize / (1024 * 1024));
      if (imageFileSizeInMB < 1) {
        emit(
          state.copyWith(
            fileSize: '${imageFileSizeInKB.toStringAsFixed(2)} KB',
          ),
        );
      } else {
        emit(
          state.copyWith(
            fileSize: '${imageFileSizeInMB.toStringAsFixed(2)} MB',
          ),
        );
      }
    } else {
      emit(
        ImageDialogState(
          fileSize: null,
        ),
      );
    }
  }

  void updateImageDimension(double value) {
    emit(
      state.copyWith(imageDimension: value),
    );
  }

  void updateImageName(String name) {
    emit(
      state.copyWith(fileName: name),
    );
  }

  Future<void> capturePng(
    RenderRepaintBoundary boundary, {
    double? targetImageDimension,
    String? fileName,
  }) async {
    logger.log(
      'Boundary width: ${boundary.size.width}, boundary height: ${boundary.size.height}',
    );
    try {
      await imageCaptureService.capturePng(
        boundary,
        targetImageDimension: targetImageDimension,
        fileName: fileName,
      );
    } on Exception catch (e) {
      String errorMessage = e.toString();
      logger.log(errorMessage);
    }
  }

  Future<void> sharePng(
    RenderRepaintBoundary boundary, {
    double? targetImageDimension,
    String? fileName,
  }) async {
    logger.log(
      'Boundary width: ${boundary.size.width}, boundary height: ${boundary.size.height}',
    );
    try {
      await imageCaptureService.sharePng(
        boundary,
        targetImageDimension: targetImageDimension,
        fileName: fileName,
      );
    } on Exception catch (e) {
      String errorMessage = e.toString();
      logger.log(errorMessage);
    }
  }
}

import 'dart:async';
import 'dart:typed_data';

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

  void updateFileSize(int byteLength) {
    final kb = byteLength / 1024;
    final mb = byteLength / (1024 * 1024);

    emit(
      state.copyWith(
        fileSize: mb < 1 ? '${kb.toStringAsFixed(2)} KB' : '${mb.toStringAsFixed(2)} MB',
      ),
    );
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
    Uint8List bytes, {
    double? targetImageDimension,
    String? fileName,
  }) async {
    try {
      await imageCaptureService.capturePng(
        bytes,
        targetImageDimension: targetImageDimension,
        fileName: fileName,
      );
    } catch (e) {
      logger.log(e.toString());
    }
  }

  Future<void> sharePng(
    Uint8List bytes, {
    double? targetImageDimension,
    String? fileName,
  }) async {
    try {
      await imageCaptureService.sharePng(
        bytes,
        targetImageDimension: targetImageDimension,
        fileName: fileName,
      );
    } catch (e) {
      logger.log(e.toString());
    }
  }
}

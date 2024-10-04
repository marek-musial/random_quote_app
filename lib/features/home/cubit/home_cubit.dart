import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gal/gal.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;

part 'home_state.dart';
part 'home_cubit.freezed.dart';
part 'home_cubit.g.dart';

ui.Image? rawImage;

@injectable
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit(this._imageRepository, this._quoteRepository) : super(const HomeState());

  final ImageRepository _imageRepository;
  final QuoteRepository _quoteRepository;
  ImageProvider? _imageProvider;

  HomeState pendingState = const HomeState(status: Status.initial);

  void resetPendingState() {
    pendingState = const HomeState(status: Status.initial);
    dev.log('pendingState reset');
  }

  Future<void> getItemModels() async {
    pendingState = pendingState.copyWith(status: Status.loading);
    emit(
      const HomeState(status: Status.loading),
    );
    try {
      final imageModel = await _imageRepository.getImageModel();
      final quoteModel = await _quoteRepository.getQuoteModel();
      pendingState = pendingState.copyWith(
        imageModel: imageModel,
        quoteModel: quoteModel,
      );
      emit(
        state.copyWith(
          imageModel: imageModel,
          quoteModel: quoteModel,
        ),
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      dev.log('$error');
      resetPendingState();
    }
  }

  Future<void> loadImage() async {
    if (pendingState.imageModel != null) {
      try {
        _imageProvider = NetworkImage(pendingState.imageModel!.imageUrl);
        final completer = Completer<ImageInfo>();
        final stream = _imageProvider!.resolve(ImageConfiguration.empty);
        final listener = ImageStreamListener(
          (info, _) {
            completer.complete(info);
          },
          onError: (dynamic error, StackTrace? stackTrace) {
            completer.completeError(error, stackTrace);
          },
        );

        stream.addListener(listener);
        final info = await completer.future;
        stream.removeListener(listener);
        final image = await info.image.toByteData(format: ui.ImageByteFormat.png);
        final codec = await ui.instantiateImageCodec(image!.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        rawImage = frame.image;

        pendingState = pendingState.copyWith.imageModel!(
          rawImage: rawImage,
        );
        emit(
          state.copyWith.imageModel!(
            rawImage: rawImage,
          ),
        );
        dev.log('Width: ${rawImage!.width}, height: ${rawImage!.height}');
      } catch (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to load image: $error',
          ),
        );
        dev.log('$error');
        resetPendingState();
      }
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'An error occured while getting the image',
        ),
      );
      resetPendingState();
    }
  }

  void randomizeTextLayout() {
    if (state.status != Status.decoding) {
      int fontWeightIndex = Random().nextInt(7) + 2;
      int textAlignmentIndex = Random().nextInt(3);
      int mainAxisAlignmentIndex = Random().nextInt(MainAxisAlignment.values.length - 3);
      int crossAxisAlignmentIndex = Random().nextInt(CrossAxisAlignment.values.length - 1);
      pendingState = pendingState.copyWith.quoteModel!(
        fontWeightIndex: fontWeightIndex,
        textAlignmentIndex: textAlignmentIndex,
        mainAxisAlignmentIndex: mainAxisAlignmentIndex,
        crossAxisAlignmentIndex: crossAxisAlignmentIndex,
      );
      dev.log('layout randomized');
    } else {
      dev.log('layout not randomized');
    }
  }

  void getTextPositionAndSize(
    Offset textPosition,
    Size textSize,
  ) {
    pendingState = pendingState.copyWith.quoteModel!(
      textPosition: textPosition,
      textSize: textSize,
    );
  }

  void calculateScaleFactor(Size? imageWidgetSize) {
    if (imageWidgetSize != null) {
      final ui.Image? image = rawImage;
      if (image == null) return;

      double rawImageWidth = image.width.toDouble();
      double rawImageHeight = image.height.toDouble();

      double widgetImageWidth = imageWidgetSize.width;
      double widgetImageHeight = imageWidgetSize.height;

      double widthScaleFactor = widgetImageWidth / rawImageWidth;
      double heightScaleFactor = widgetImageHeight / rawImageHeight;

      pendingState = pendingState.copyWith.imageModel!(
        scaleFactor: widthScaleFactor < heightScaleFactor ? widthScaleFactor : heightScaleFactor,
      );
      dev.log('scaleFactor: ${pendingState.imageModel?.scaleFactor}');
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'scale factor calculation error! Widget size is null!',
        ),
      );
      resetPendingState();
    }
  }

  PaletteGenerator? paletteGenerator;
  final _placeholderColor = Colors.white;

  Future<void> generateColors() async {
    final ImageModel? pendingImageModel = pendingState.imageModel;
    final QuoteModel? pendingQuoteModel = pendingState.quoteModel;
    final double? scaleFactor = pendingState.imageModel?.scaleFactor;

    if (scaleFactor != null &&
        _imageProvider != null &&
        pendingImageModel?.rawImage != null &&
        pendingQuoteModel?.textPosition != null &&
        pendingQuoteModel?.textSize != null) {
      try {
        final scaledImageSize = Size(pendingImageModel!.rawImage!.width * scaleFactor, pendingImageModel.rawImage!.height * scaleFactor);
        final bottomRight = pendingQuoteModel!.textPosition! +
            Offset(
              pendingState.quoteModel!.textSize!.width,
              pendingState.quoteModel!.textSize!.height,
            );
        final region = Rect.fromPoints(
          pendingQuoteModel.textPosition!,
          Offset(
            bottomRight.dx.clamp(1, scaledImageSize.width - pendingQuoteModel.textPosition!.dx),
            bottomRight.dy.clamp(1, scaledImageSize.height - pendingQuoteModel.textPosition!.dy),
          ),
        );

        paletteGenerator = await PaletteGenerator.fromImageProvider(
          _imageProvider!,
          size: scaledImageSize,
          region: region,
        );
        dev.log('palette generated!');
      } catch (error) {
        emit(
          HomeState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
        dev.log('$error');
        resetPendingState();
      }
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'Error while generating color',
        ),
      );
      resetPendingState();
    }

    final paletteColor = paletteGenerator != null
        ? paletteGenerator!.dominantColor != null
            ? paletteGenerator!.dominantColor!.color
            : paletteGenerator!.vibrantColor != null
                ? paletteGenerator!.vibrantColor!.color
                : _placeholderColor
        : _placeholderColor;

    pendingState = pendingState.copyWith.quoteModel!(
      textColor: _getInverseColor(
        paletteColor.withOpacity(1),
      ),
    );
    dev.log('textColor = ${pendingState.quoteModel?.textColor}');
  }

  Color _getInverseColor(Color color) {
    if (color.red > 225 && color.green > 225 && color.blue > 225) {
      return Colors.black;
    }
    if (color.red < 60 && color.green < 60 && color.blue < 60) {
      return Colors.white;
    } else {
      final inverseColor = Color.fromRGBO(
        255 - color.red,
        255 - color.green,
        255 - color.blue,
        1,
      );
      return inverseColor;
    }
  }

  void emitSuccess() {
    emit(
      pendingState.copyWith(status: Status.success),
    );
    dev.log('success');
  }

  void start() async {
    switch (state.status) {
      case Status.initial || Status.success || Status.error:
        resetPendingState();
        await getItemModels();
        await loadImage();
        break;
      case Status.decoding:
        resetPendingState();
        pendingState = state;
        await loadImage();
        break;
      case Status.loading:
        emit(
          const HomeState(
            status: Status.error,
            errorMessage: 'Another process in progress, please wait.',
          ),
        );
        break;
      default:
        emit(
          const HomeState(
            status: Status.error,
            errorMessage: 'Wrong status!',
          ),
        );
        break;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    if (state.status == Status.success && state.imageModel != _fromJsonState.imageModel && state.quoteModel != _fromJsonState.quoteModel) {
      final Map<String, dynamic> map = state.toJson();
      return map;
    } else {
      return null;
    }
  }

  HomeState _fromJsonState = const HomeState();

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final jsonState = HomeState.fromJson(json);
      _fromJsonState = jsonState.copyWith(status: Status.decoding);
      return jsonState.copyWith(status: Status.decoding);
    } catch (e) {
      dev.log('Error on HomeState fromJson: $e');
      return null;
    }
  }

  Future<void> capturePng(RenderRepaintBoundary boundary) async {
    dev.log('Boundary width: ${boundary.size.width}, boundary height: ${boundary.size.height}');
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    String timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    try {
      await Gal.putImageBytes(
        pngBytes,
        name: 'image_$timestamp',
      );
    } on GalException catch (e) {
      String galErrorMessage = e.type.message;
      emit(
        HomeState(
          status: Status.error,
          errorMessage: galErrorMessage,
        ),
      );
      dev.log(galErrorMessage);
    }
    dev.log('Saved image width: ${image.width}, saved image height: ${image.height}');
  }
}

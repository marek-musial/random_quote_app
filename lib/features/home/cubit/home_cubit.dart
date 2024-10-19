import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gal/gal.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;

part 'home_state.dart';
part 'home_cubit.freezed.dart';
part 'home_cubit.g.dart';

ImageProvider? imageProvider;
Logger homeCubitLogger = Logger();

class ImageLoader {
  Future<ui.Image> loadImage(String url) async {
    imageProvider = NetworkImage(url);
    final completer = Completer<ImageInfo>();
    final stream = imageProvider?.resolve(ImageConfiguration.empty);

    final listener = ImageStreamListener(
      (info, _) {
        completer.complete(info);
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.completeError(error, stackTrace);
      },
    );

    stream?.addListener(listener);
    final info = await completer.future;
    stream?.removeListener(listener);

    final byteData = await info.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final codec = await ui.instantiateImageCodec(
      byteData!.buffer.asUint8List(),
    );
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}

class PaletteGeneratorService {
  Future<Color> generateColors(
    Size scaledImageSize,
    Rect region,
  ) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider!,
      size: scaledImageSize,
      region: region,
    );
    const placeholderColor = Colors.white;
    final paletteColor = paletteGenerator.dominantColor != null
        ? paletteGenerator.dominantColor!.color
        : paletteGenerator.vibrantColor != null
            ? paletteGenerator.vibrantColor!.color
            : placeholderColor;
    return paletteColor;
  }
}

class ImageCaptureService {
  Future<void> capturePng(RenderRepaintBoundary boundary) async {
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    String timestamp = DateFormat('yyyyMMdd_HHmmssSSS').format(DateTime.now());
    await Gal.putImageBytes(
      pngBytes,
      name: 'image_$timestamp',
    );
    homeCubitLogger.log('Saved image width: ${image.width}, saved image height: ${image.height}');
  }

  Future<void> sharePng(RenderRepaintBoundary boundary) async {
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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
      homeCubitLogger.log(
        'Shared image width: ${image.width}, saved image height: ${image.height}',
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      homeCubitLogger.log(
        'Image sharing dismissed',
      );
    } else {
      homeCubitLogger.log(
        'An error occured with share result status ${result.status.toString()}',
      );
    }
  }
}

@injectable
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit(
    this._imageRepository,
    this._quoteRepository,
  ) : super(const HomeState());

  Logger logger = homeCubitLogger;
  final ImageRepository _imageRepository;
  final QuoteRepository _quoteRepository;
  ImageLoader imageLoader = ImageLoader();
  PaletteGeneratorService paletteGeneratorService = PaletteGeneratorService();
  ImageCaptureService imageCaptureService = ImageCaptureService();

  HomeState pendingState = const HomeState(status: Status.initial);

  void resetPendingState() {
    pendingState = const HomeState(status: Status.initial);
    logger.log('pendingState reset');
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
      logger.log('$error');
      resetPendingState();
    }
  }

  Future<void> loadImage() async {
    if (pendingState.imageModel != null) {
      try {
        ui.Image? rawImage = await imageLoader.loadImage(pendingState.imageModel!.imageUrl);

        pendingState = pendingState.copyWith.imageModel!(
          rawImage: rawImage,
        );
        emit(
          state.copyWith.imageModel!(
            rawImage: rawImage,
          ),
        );
        logger.log('Width: ${rawImage.width}, height: ${rawImage.height}');
      } catch (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to load image: $error',
          ),
        );
        logger.log('$error');
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
      int crossAxisAlignmentIndex = Random().nextInt(CrossAxisAlignment.values.length - 2);
      pendingState = pendingState.copyWith.quoteModel!(
        fontWeightIndex: fontWeightIndex,
        textAlignmentIndex: textAlignmentIndex,
        mainAxisAlignmentIndex: mainAxisAlignmentIndex,
        crossAxisAlignmentIndex: crossAxisAlignmentIndex,
      );
      logger.log('layout randomized');
    } else {
      logger.log('layout not randomized');
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

  void calculateScaleFactor(Size imageWidgetSize) {
    final ui.Image? image = pendingState.imageModel?.rawImage;
    if (image != null) {
      double rawImageWidth = image.width.toDouble();
      double rawImageHeight = image.height.toDouble();

      double widgetImageWidth = imageWidgetSize.width;
      double widgetImageHeight = imageWidgetSize.height;

      double widthScaleFactor = widgetImageWidth / rawImageWidth;
      double heightScaleFactor = widgetImageHeight / rawImageHeight;

      pendingState = pendingState.copyWith.imageModel!(
        scaleFactor: widthScaleFactor < heightScaleFactor ? widthScaleFactor : heightScaleFactor,
      );
      logger.log('scaleFactor: ${pendingState.imageModel?.scaleFactor}');
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'scale factor calculation error',
        ),
      );
      resetPendingState();
    }
  }

  Future<void> generateColors() async {
    final ImageModel? pendingImageModel = pendingState.imageModel;
    final QuoteModel? pendingQuoteModel = pendingState.quoteModel;
    final double? scaleFactor = pendingState.imageModel?.scaleFactor;

    if (scaleFactor != null &&
        imageProvider != null &&
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

        final paletteColor = await paletteGeneratorService.generateColors(
          scaledImageSize,
          region,
        );

        pendingState = pendingState.copyWith.quoteModel!(
          textColor: getInverseColor(
            paletteColor.withOpacity(1),
          ),
        );

        logger.log('textColor = ${pendingState.quoteModel?.textColor}');
        logger.log('palette generated!');
      } catch (error) {
        emit(
          HomeState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
        logger.log('$error');
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
  }

  Color getInverseColor(Color color) {
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
    logger.log('success');
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
      logger.log('Error on HomeState fromJson: $e');
      return null;
    }
  }

  Future<void> capturePng(RenderRepaintBoundary boundary) async {
    logger.log('Boundary width: ${boundary.size.width}, boundary height: ${boundary.size.height}');
    try {
      await imageCaptureService.capturePng(boundary);
    } on Exception catch (e) {
      String errorMessage = e.toString();
      emit(
        HomeState(
          status: Status.error,
          errorMessage: errorMessage,
        ),
      );
      logger.log(errorMessage);
    }
  }
}

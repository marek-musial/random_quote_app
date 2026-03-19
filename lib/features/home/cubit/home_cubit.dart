import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/core/extensions.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/network_utils.dart';
import 'package:random_quote_app/core/services/palette_generator_service.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/home/models/composition_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';
part 'home_cubit.g.dart';

@injectable
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit(
    this._imageRepository,
    this._quoteRepository,
  ) : super(const HomeState());

  Logger logger = globalLogger;
  final ImageRepository _imageRepository;
  final QuoteRepository _quoteRepository;
  final PaletteGeneratorService _paletteGeneratorService = PaletteGeneratorService();

  Size? _widgetSize;
  bool _initialized = false;

  ui.Image? _rawImage;
  ui.Image? _resizedImage;

  double? _scaleFactor;

  CompositionModel? compositionModel;

  Future<void> ensureInitialized(Size size) async {
    if (_initialized) return;

    _initialized = true;
    _widgetSize = size;
    logger.log('Widget size: $_widgetSize');

    if (state.status == Status.success && //R
        state.imageModel != null &&
        state.quoteModel != null &&
        state.compositionModel != null) {
      await _resumeFromHydratedState();
      return;
    }
    await _runLoadingCycle();
  }

  Future<void> reload() async {
    if (_widgetSize == null) return;
    await _runLoadingCycle();
  }

  Future<void> _runLoadingCycle() async {
    final bool isConnected = await NetworkUtils.checkConnectivity();

    if (!isConnected) {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'Check your network connection',
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: Status.loading));

      final imageModel = await _imageRepository.getImageModel();
      final quoteModel = await _quoteRepository.getQuoteModel();
      compositionModel ??= CompositionModel();

      _rawImage = await _loadImage(imageModel!.imageUrl);

      _resizedImage = await _resizeForSquareContain(
        _rawImage!,
        _widgetSize!.height,
      );

      _randomizeTextLayout();

      final textColor = await generateTextColor(
        quoteModel: quoteModel!,
        compositionModel: compositionModel!,
      );

      compositionModel?.textColor = textColor;
      compositionModel?.rawImage = _rawImage;

      emit(
        HomeState(
          status: Status.success,
          imageModel: imageModel,
          quoteModel: quoteModel,
          compositionModel: compositionModel,
        ),
      );

      logger.log('Home loaded successfully');
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
      logger.log('$error');
    }
  }

  Future<ui.Image> _loadImage(String url) async {
    final imageProvider = NetworkImage(url);
    final completer = Completer<ImageInfo>();
    final stream = imageProvider.resolve(ImageConfiguration.empty);

    final listener = ImageStreamListener(
      (info, _) => completer.complete(info),
      onError: (error, stackTrace) => completer.completeError(error, stackTrace),
    );

    stream.addListener(listener);
    final info = await completer.future;
    stream.removeListener(listener);

    final byteData = await info.image.toByteData(format: ui.ImageByteFormat.png);

    final codec = await ui.instantiateImageCodec(
      byteData!.buffer.asUint8List(),
    );

    final frame = await codec.getNextFrame();
    final image = frame.image;
    logger.log('Raw Image - Width: ${image.width}, height: ${image.height}');
    return image;
  }

  Future<ui.Image> _resizeForSquareContain(
    ui.Image rawImage,
    double squareSize,
  ) async {
    final rawWidth = rawImage.width.toDouble();
    final rawHeight = rawImage.height.toDouble();

    _scaleFactor = squareSize / (rawWidth < rawHeight ? rawWidth : rawHeight);
    logger.log('Resized image by scale: $_scaleFactor');

    final targetWidth = (rawWidth * _scaleFactor!).round();
    final targetHeight = (rawHeight * _scaleFactor!).round();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..filterQuality = FilterQuality.medium;

    canvas.drawImageRect(
      rawImage,
      Rect.fromLTWH(0, 0, rawWidth, rawHeight),
      Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()),
      paint,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(targetWidth, targetHeight);
    logger.log('Resized Image - Width: ${image.width}, height: ${image.height}');
    return image;
  }

  void _randomizeTextLayout() {
    int fontWeightIndex = Random().nextInt(6) + 3; //[w400, w500, w600, w700, w800, w900]
    int textAlignmentIndex = Random().nextInt(3); //[left, right, center]
    int mainAxisAlignmentIndex = Random().nextInt(3); //[start, end, center]
    int crossAxisAlignmentIndex = Random().nextInt(3); //[start, end, center]

    compositionModel = compositionModel?.copyWith(
        fontWeightIndex: fontWeightIndex,
        textAlignmentIndex: textAlignmentIndex,
        mainAxisAlignmentIndex: mainAxisAlignmentIndex,
        crossAxisAlignmentIndex: crossAxisAlignmentIndex);

    logger.log('Layout randomized');
  }

  void calculateFontSize(
    double containerHeight, {
    required QuoteModel quoteModel,
  }) {
    final length = quoteModel.quote.length;
    final author = quoteModel.author;

    compositionModel!.fontSize = switch (length) {
      <= 20 => containerHeight ~/ 10,
      <= 160 => containerHeight ~/ 14,
      <= 300 => containerHeight ~/ 20,
      <= 540 => containerHeight ~/ 24,
      <= 710 => containerHeight ~/ 28,
      <= 900 => containerHeight ~/ 32,
      _ => containerHeight ~/ 36,
    };
    logger.log('Quote font size: ${compositionModel!.fontSize}');

    if (author != null) {
      final length = quoteModel.quote.length;

      compositionModel!.authorFontSize = switch (length) {
        <= 300 => containerHeight ~/ 24,
        <= 540 => containerHeight ~/ 26,
        <= 710 => containerHeight ~/ 30,
        <= 900 => containerHeight ~/ 34,
        _ => containerHeight ~/ 38,
      };
      logger.log('Author font size: ${compositionModel!.authorFontSize}');
    }
  }

  Offset calculateTextPosition(
    Size textPositionContainerSize,
    Size textSize,
    int? mainAxisIndex,
    int? crossAxisIndex,
  ) {
    double dx;
    double dy;

    switch (crossAxisIndex) {
      case 0: // start
        dx = 0;
        break;
      case 1: // end
        dx = textPositionContainerSize.width - textSize.width;
        break;
      case 2: // center
        dx = (textPositionContainerSize.width - textSize.width) / 2;
        break;
      default:
        dx = 0;
    }

    switch (mainAxisIndex) {
      case 0: //start
        dy = 0;
        break;
      case 1: //end
        dy = textPositionContainerSize.height - textSize.height;
        break;
      case 2: //center
        dy = (textPositionContainerSize.height - textSize.height) / 2;
        break;
      default:
        dy = 0;
    }

    final position = Offset(dx, dy);
    logger.log('Text within text area position: $position');
    return position;
  }

  Future<Color> generateTextColor({
    required QuoteModel quoteModel,
    required CompositionModel compositionModel,
  }) async {
    final quote = quoteModel.quote;

    final imageDisplaySize = _widgetSize!; // 7/8 container

    calculateFontSize(
      imageDisplaySize.height,
      quoteModel: quoteModel,
    );

    final fontSize = compositionModel.fontSize?.toDouble();

    final textPainter = TextPainter(
      textAlign: TextAlign.values[compositionModel.textAlignmentIndex ?? 2],
      text: TextSpan(
        text: quote,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.values[compositionModel.fontWeightIndex ?? 4],
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    final textContainerSize = Size(
      (imageDisplaySize.width * 6 / 7).roundToDouble(),
      (imageDisplaySize.height * 6 / 7).roundToDouble(),
    );
    logger.log('New textContainerSize: $textContainerSize');

    textPainter.layout(
      maxWidth: textContainerSize.width,
    );

    final textSize = textPainter.size;
    logger.log('New textSize: $textSize');

    final textPositionInsideContainer = calculateTextPosition(
      textContainerSize,
      textSize,
      compositionModel.mainAxisAlignmentIndex,
      compositionModel.crossAxisAlignmentIndex,
    );

    final textContainerOffset = Offset(
      (imageDisplaySize.width - textContainerSize.width) / 2,
      (imageDisplaySize.height - textContainerSize.height) / 2,
    );

    final finalWidgetTextPosition = textContainerOffset + textPositionInsideContainer;

    final region = Rect.fromLTRB(
      finalWidgetTextPosition.dx.clamp(
        textContainerOffset.dx,
        _resizedImage!.width.toDouble() - textContainerOffset.dx,
      ),
      finalWidgetTextPosition.dy.clamp(
        textContainerOffset.dy,
        _resizedImage!.height.toDouble() - textContainerOffset.dy,
      ),
      (finalWidgetTextPosition.dx + textSize.width).clamp(
        textContainerOffset.dx,
        _resizedImage!.width.toDouble() - textContainerOffset.dx,
      ),
      (finalWidgetTextPosition.dy + textSize.height).clamp(
        textContainerOffset.dy,
        _resizedImage!.height.toDouble() - textContainerOffset.dy,
      ),
    );
    logger.log('Color sampling region: $region');

    final paletteColor = await _paletteGeneratorService.generateColors(
      _resizedImage!,
      Size(
        _resizedImage!.width.toDouble(),
        _resizedImage!.height.toDouble(),
      ),
      region,
    );

    final color = paletteColor.inverseColor();
    logger.log('Generated TextColor = $color');
    return color;
  }

  Future<void> _resumeFromHydratedState() async {
    emit(state.copyWith(status: Status.loading));

    try {
      _rawImage = await _loadImage(state.imageModel!.imageUrl);
      state.compositionModel!.rawImage = _rawImage;

      emit(
        state.copyWith(
          status: Status.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    if (state.status == Status.success && //R
        state.imageModel != _fromJsonState.imageModel &&
        state.quoteModel != _fromJsonState.quoteModel &&
        state.compositionModel != _fromJsonState.compositionModel) {
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
      _fromJsonState = jsonState;
      return jsonState;
    } catch (e) {
      logger.log('Error restoring HomeState: $e');
      return null;
    }
  }
}

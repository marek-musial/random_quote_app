import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;

part 'home_state.dart';

ui.Image? rawImage;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._imageRepository, this._quoteRepository) : super(const HomeState());

  final ImageRepository _imageRepository;
  final QuoteRepository _quoteRepository;
  ImageProvider? _imageProvider;

  Future<void> getItemModels() async {
    if (state.status != Status.loading) {
      emit(
        const HomeState(status: Status.loading),
      );
      try {
        final imageModel = await _imageRepository.getImageModel();
        final quoteModel = await _quoteRepository.getQuoteModel();
        emit(
          HomeState(
            imageModel: imageModel,
            quoteModel: quoteModel,
          ),
        );
        await loadImage();
      } catch (error) {
        emit(
          HomeState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'Another process in progress, please wait.',
        ),
      );
    }
  }

  Future<void> loadImage() async {
    if (state.imageModel != null) {
      try {
        _imageProvider = NetworkImage(state.imageModel!.imageUrl);
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

        emit(
          state.copyWith(
            rawImage: rawImage,
          ),
        );
        print('Width: ${rawImage!.width}, height: ${rawImage!.height}');
      } catch (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to load image: $error',
          ),
        );
      }
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'An error occured while getting the image',
        ),
      );
    }
  }

  void randomizeTextLayout() {
    int fontWeightIndex = Random().nextInt(7) + 2;
    int textAlignmentIndex = Random().nextInt(3);
    int mainAxisAlignmentIndex = Random().nextInt(MainAxisAlignment.values.length - 3);
    int crossAxisAlignmentIndex = Random().nextInt(CrossAxisAlignment.values.length - 1);
    emit(
      state.copyWith(
        fontWeightIndex: fontWeightIndex,
        textAlignmentIndex: textAlignmentIndex,
        mainAxisAlignmentIndex: mainAxisAlignmentIndex,
        crossAxisAlignmentIndex: crossAxisAlignmentIndex,
      ),
    );
    print('layout randomized');
  }

  void calculatePosition({BuildContext? imageContext, BuildContext? textContext}) {
    randomizeTextLayout();
    if (imageContext != null && textContext != null && imageContext.mounted && textContext.mounted) {
      final RenderBox imageRenderBox = imageContext.findRenderObject() as RenderBox;
      final RenderBox textRenderBox = textContext.findRenderObject() as RenderBox;
      final textPosition = imageRenderBox.globalToLocal(
        Offset(
          textRenderBox.localToGlobal(Offset.zero).dx,
          textRenderBox.localToGlobal(Offset.zero).dy,
        ),
      );
      emit(
        state.copyWith(
          textPosition: textPosition,
          textSize: textRenderBox.size,
        ),
      );
      print('textPosition ${state.textPosition}, textSize ${state.textSize}, imageSize ${imageRenderBox.size}');
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'image context or text context missing!',
        ),
      );
    }
  }

  void calculateScaleFactor(BuildContext? context) {
    if (context != null && context.mounted) {
      final ui.Image? image = rawImage;
      if (image == null) return;

      double rawImageWidth = image.width.toDouble();
      double rawImageHeight = image.height.toDouble();

      double widgetImageWidth = MediaQuery.of(context).size.width;
      double widgetImageHeight = MediaQuery.of(context).size.height;

      double widthScaleFactor = widgetImageWidth / rawImageWidth;
      double heightScaleFactor = widgetImageHeight / rawImageHeight;

      emit(
        state.copyWith(
          scaleFactor: widthScaleFactor < heightScaleFactor ? widthScaleFactor : heightScaleFactor,
        ),
      );
      print('scaleFactor: ${state.scaleFactor}');
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'scale factor calculation context error!',
        ),
      );
    }
  }

  PaletteGenerator? paletteGenerator;
  final _placeholderColor = Colors.white;

  Future<void> generateColors() async {
    final double? scaleFactor = state.scaleFactor;

    if (scaleFactor != null && _imageProvider != null && state.rawImage != null && state.textPosition != null && state.textSize != null) {
      try {
        final scaledImageSize = Size(state.rawImage!.width * scaleFactor, state.rawImage!.height * scaleFactor);
        final bottomRight = state.textPosition! + Offset(state.textSize!.width, state.textSize!.height);
        final region = Rect.fromPoints(
          state.textPosition!,
          Offset(
            bottomRight.dx.clamp(1, scaledImageSize.width - state.textPosition!.dx),
            bottomRight.dy.clamp(1, scaledImageSize.height - state.textPosition!.dy),
          ),
        );

        paletteGenerator = await PaletteGenerator.fromImageProvider(
          _imageProvider!,
          size: scaledImageSize,
          region: region,
        );
        print('palette generated!');
      } catch (error) {
        emit(
          HomeState(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      }
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'Error while generating color',
        ),
      );
    }

    final paletteColor = paletteGenerator != null
        ? paletteGenerator!.dominantColor != null
            ? paletteGenerator!.dominantColor!.color
            : paletteGenerator!.vibrantColor != null
                ? paletteGenerator!.vibrantColor!.color
                : _placeholderColor
        : _placeholderColor;

    emit(
      state.copyWith(
        textColor: _getInverseColor(
          paletteColor.withOpacity(1),
        ),
      ),
    );
    print('textColor = ${state.textColor}');
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
      state.copyWith(status: Status.success),
    );
  }

  void start() async {
    await getItemModels();
  }
}

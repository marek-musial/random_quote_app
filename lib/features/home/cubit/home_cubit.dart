import 'dart:async';

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
    emit(const HomeState(status: Status.loading));
    try {
      final imageModel = await _imageRepository.getImageModel();
      final quoteModel = await _quoteRepository.getQuoteModel();
      emit(
        HomeState(
          imageModel: imageModel,
          quoteModel: quoteModel,
        ),
      );
      loadImage();
    } catch (error) {
      emit(HomeState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> loadImage() async {
    if (state.imageModel != null) {
      _imageProvider = NetworkImage(state.imageModel!.imageUrl);
      final completer = Completer<ImageInfo>();
      final stream = _imageProvider!.resolve(ImageConfiguration.empty);
      stream.addListener(
        ImageStreamListener(
          (info, _) {
            completer.complete(info);
          },
        ),
      );
      final info = await completer.future;
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
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'imageModel == null!',
        ),
      );
    }
  }

  calculatePosition({BuildContext? imageContext, BuildContext? textContext}) {
    if (imageContext != null && textContext != null) {
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
    }
  }

  void calculateScaleFactor(BuildContext context) {
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
  }

  PaletteGenerator? paletteGenerator;
  final _placeholderColor = Colors.white;

  Future<void> generateColors() async {
    final double? scaleFactor = state.scaleFactor;

    if (scaleFactor != null && _imageProvider != null && state.rawImage != null && state.textPosition != null && state.textSize != null) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        _imageProvider!,
        size: Size(state.rawImage!.width * scaleFactor, state.rawImage!.height * scaleFactor),
        region: Rect.fromPoints(
          state.textPosition!,
          state.textPosition! + Offset(state.textSize!.width, state.textSize!.height),
        ),
      );
    } else {}

    final paletteColor = paletteGenerator != null
        ? paletteGenerator!.vibrantColor != null
            ? paletteGenerator!.vibrantColor!.bodyTextColor
            : paletteGenerator!.dominantColor != null
                ? paletteGenerator!.dominantColor!.bodyTextColor
                : _placeholderColor
        : _placeholderColor;

    emit(
      state.copyWith(
        textColor: paletteColor,
      ),
    );
    print('textColor = ${state.textColor}');
  }

  Color _getInverseColor(Color color) {
    final inverseColor = Color.fromRGBO(
      255 - color.red,
      255 - color.green,
      255 - color.blue,
      1,
    );
    return inverseColor;
  }

  void emitSuccess() {
    emit(state.copyWith(status: Status.success));
  }

  void start() {
    emit(const HomeState(status: Status.loading));
    getItemModels();
  }
}

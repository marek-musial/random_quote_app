import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
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

      print('Width: ${rawImage!.width}, height: ${rawImage!.height}');

      emit(
        state.copyWith(
          rawImage: rawImage,
        ),
      );
    } else {
      emit(
        const HomeState(
          status: Status.error,
          errorMessage: 'imageModel == null!',
        ),
      );
    }
  }

  void start() {
    emit(const HomeState(status: Status.loading));
    getItemModels();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._imageRepository, this._quoteRepository) : super(const HomeState());

  final ImageRepository _imageRepository;
  final QuoteRepository _quoteRepository;

  Future<void> getItemModels() async {
    emit(const HomeState(status: Status.loading));
    try {
      final imageModel = await _imageRepository.getImageModel();
      final quoteModel = await _quoteRepository.getQuoteModel();
      emit(
        HomeState(
          imageModel: imageModel,
          quoteModel: quoteModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(HomeState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void start() {
    emit(const HomeState(status: Status.loading));
    getItemModels();
  }
}

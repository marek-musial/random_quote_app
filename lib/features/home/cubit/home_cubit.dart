import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/enums.dart';
import 'package:random_quote_app/domain/models/image_model.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._imageRepository) : super(const HomeState());

  final ImageRepository _imageRepository;

  Future<void> getImageModel() async {
    emit(const HomeState(status: Status.loading));
    try {
      final imageModel = await _imageRepository.getImageModel();
      emit(
        HomeState(
          imageModel: imageModel,
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
    getImageModel();
  }
}

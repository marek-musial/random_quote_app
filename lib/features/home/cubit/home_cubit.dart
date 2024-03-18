import 'package:bloc/bloc.dart';
import 'package:random_quote_app/core/enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void start() {
    emit(const HomeState(status: Status.loading));
  }
}

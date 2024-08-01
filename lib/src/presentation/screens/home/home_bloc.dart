import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AccountUseCase _accountUseCase;

  HomeBloc(this._accountUseCase)
      : super(
          const HomeState(),
        ){
    on(_onInit);
  }

  void _onInit(
    HomeOnInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final activeAccount = await _accountUseCase.getFirstAccount();

      emit(
        state.copyWith(
          activeAccount: activeAccount,
        ),
      );
    } catch (e) {
      LogProvider.log('Home screen fetch account error ${e.toString()}');
    }
  }
}

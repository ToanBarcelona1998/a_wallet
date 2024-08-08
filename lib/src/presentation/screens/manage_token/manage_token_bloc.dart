import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_token_event.dart';
import 'manage_token_state.dart';

final class ManageTokenBloc extends Bloc<ManageTokenEvent, ManageTokenState> {
  final TokenUseCase _tokenUseCase;
  ManageTokenBloc(this._tokenUseCase)
      : super(
          const ManageTokenState(),
        ){
    on(_onInit);
  }

  void _onInit(
    ManageTokenOnInitEvent event,
    Emitter<ManageTokenState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ManageTokenStatus.loading,
        ),
      );

      final tokens = await _tokenUseCase.getAll();

      emit(
        state.copyWith(
          status: ManageTokenStatus.loaded,
          tokens: tokens,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ManageTokenStatus.error,
        ),
      );
    }
  }
}

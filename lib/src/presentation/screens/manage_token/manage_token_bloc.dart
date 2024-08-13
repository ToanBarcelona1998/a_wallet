import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_token_event.dart';
import 'manage_token_state.dart';

final class ManageTokenBloc extends Bloc<ManageTokenEvent, ManageTokenState> {
  final TokenUseCase _tokenUseCase;

  ManageTokenBloc(this._tokenUseCase)
      : super(
          const ManageTokenState(),
        ) {
    on(_onInit);
    on(_onSearch);
    on(_onDenounce);
    on(_onDenounceDone);
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
      LogProvider.log('Manage token on init error ${e.toString()}');
      emit(
        state.copyWith(
          status: ManageTokenStatus.error,
        ),
      );
    }
  }

  void _onSearch(
      ManageTokenOnSearchEvent event, Emitter<ManageTokenState> emit) async {
    try {
      emit(
        state.copyWith(
          status: ManageTokenStatus.loading,
        ),
      );

      if (event.tokenName.isEmpty) {
        final tokens = await _tokenUseCase.getAll();

        emit(
          state.copyWith(
            status: ManageTokenStatus.loaded,
            tokens: tokens,
          ),
        );
      } else {
        final tokens = state.tokens
            .where(
              (e) => e.tokenName.contains(event.tokenName),
            )
            .toList();

        emit(
          state.copyWith(
            status: ManageTokenStatus.loaded,
            tokens: tokens,
          ),
        );
      }
    } catch (e) {
      LogProvider.log('Manage token on init error ${e.toString()}');
      emit(
        state.copyWith(
          status: ManageTokenStatus.error,
        ),
      );
    }
  }

  void _onDenounce(
      ManageTokenOnDenounceEvent event, Emitter<ManageTokenState> emit) {
    final List<Token> tokens = [...state.tokens];

    int index = state.tokens.indexOf(event.token);

    tokens.removeAt(index);

    Token token = event.token;

    token = token.copyWithEnable();

    tokens.insert(index, token);

    emit(
      state.copyWith(
        tokens: tokens,
      ),
    );
  }

  void _onDenounceDone(ManageTokenOnDenounceDoneEvent event,
      Emitter<ManageTokenState> emit) async {
    final token = event.token;

    final t = state.tokens.firstWhereOrNull(
      (t) => t.id == token.id,
    );

    await _tokenUseCase.update(
      UpdateTokenRequest(
        id: token.id,
        logo: t?.logo,
        tokenName: t?.tokenName,
        type: t?.type,
        symbol: t?.symbol,
        contractAddress: t?.contractAddress,
        isEnable: t?.isEnable,
      ),
    );

    emit(
      state.copyWith(
        status: ManageTokenStatus.onChangeDone,
      ),
    );
  }
}

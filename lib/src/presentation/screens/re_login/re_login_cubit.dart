import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/helpers/crypto_helper.dart';

import 're_login_state.dart';

final class ReLoginCubit extends Cubit<ReLoginState> {
  final AppSecureUseCase _appSecureUseCase;
  final AccountUseCase _accountUseCase;

  ReLoginCubit(
    this._appSecureUseCase,
    this._accountUseCase,
  ) : super(
          const ReLoginState(),
        );

  void userInputPassword({required String inputPasscode}) async {
    try {
      final String? passcode = await _appSecureUseCase.getCurrentPasscode(
        key: AppLocalConstant.passCodeKey,
      );

      String passCodeCompare = CryptoHelper.hashStringBySha256(inputPasscode);

      if (passcode == passCodeCompare) {
        final account = await _accountUseCase.getFirstAccount();

        ReLoginStatus status = ReLoginStatus.nonHasAccounts;

        if (account != null) {
          status = ReLoginStatus.hasAccounts;
        }

        emit(
          state.copyWith(
            status: status,
          ),
        );
      } else {
        if (state.wrongCountDown == 0) {
          emit(
            state.copyWith(
              status: ReLoginStatus.lockTime,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ReLoginStatus.wrongPassword,
              wrongCountDown: state.wrongCountDown - 1,
            ),
          );
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ReLoginStatus.wrongPassword,
        ),
      );
    }
  }

  void unLockInputPassword() {
    emit(
      state.copyWith(
        wrongCountDown: 10,
        status: ReLoginStatus.none,
      ),
    );
  }
}

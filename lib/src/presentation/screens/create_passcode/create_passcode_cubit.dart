import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/helpers/crypto_helper.dart';
import 'package:wallet_core/wallet_core.dart';

import 'create_passcode_state.dart';

class CreatePasscodeCubit extends Cubit<CreatePasscodeState> {
  final AppSecureUseCase _appSecureUseCase;

  CreatePasscodeCubit(this._appSecureUseCase)
      : super(
    const CreatePasscodeState(
      status: CreatePasscodeStatus.init,
    ),
  );

  Future<void> savePasscode(String passCode) async {
    emit(
      state.copyWith(
        status: CreatePasscodeStatus.onSavePasscode,
      ),
    );

    try {
      String hashPassCode = CryptoHelper.hashStringBySha256(passCode);

      await _appSecureUseCase.storePasscode(
        key: AppLocalConstant.passCodeKey,
        passcode: hashPassCode,
      );
    } catch (e) {
      //
    } finally {
      emit(
        state.copyWith(
          status: CreatePasscodeStatus.savePasscodeDone,
        ),
      );
    }
  }
}

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/helpers/crypto_helper.dart';
import 'setting_change_passcode_state.dart';

final class SettingChangePasscodeCubit
    extends Cubit<SettingChangePasscodeState> {
  final AppSecureUseCase _appSecureUseCase;

  SettingChangePasscodeCubit(this._appSecureUseCase)
      : super(
          const SettingChangePasscodeState(),
        );

  void onEnterPasscodeDone(List<String> passcode) async {
    final String? currentPasscode = await _appSecureUseCase.getCurrentPasscode(
      key: AppLocalConstant.passCodeKey,
    );

    String passCodeCompare = CryptoHelper.hashStringBySha256(passcode.join(''));

    SettingChangePassCodeStatus status = passCodeCompare == currentPasscode
        ? SettingChangePassCodeStatus.enterPasscodeSuccessful
        : SettingChangePassCodeStatus.enterPasscodeWrong;

    emit(state.copyWith(
      status: status,
    ));
  }

  void onCreatePassCodeDone(List<String> newPasscodes) {
    emit(state.copyWith(
      status: SettingChangePassCodeStatus.createNewPassCodeDone,
      passCodes: List.empty(growable: true)..addAll(newPasscodes),
    ));
  }

  void onConfirmPassCodeDone(List<String> confirmPasscodes) async {
    String passCodes = state.passCodes.join('');

    SettingChangePassCodeStatus status = passCodes == confirmPasscodes.join('')
        ? SettingChangePassCodeStatus.confirmPassCodeSuccessful
        : SettingChangePassCodeStatus.confirmPasscodeWrong;

    if (status == SettingChangePassCodeStatus.confirmPassCodeSuccessful) {

      String hashPassCode = CryptoHelper.hashStringBySha256(passCodes);
      await _appSecureUseCase.storePasscode(
        key: AppLocalConstant.passCodeKey,
        passcode: hashPassCode,
      );
    }

    emit(state.copyWith(
      status: status,
    ));
  }
}

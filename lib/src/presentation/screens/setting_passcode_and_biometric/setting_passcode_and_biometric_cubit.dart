import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_passcode_and_biometric_state.dart';

final class SettingPasscodeAndBiometricCubit
    extends Cubit<SettingPassCodeAndBiometricState> {
  final AppSecureUseCase _appSecureUseCase;

  SettingPasscodeAndBiometricCubit(this._appSecureUseCase)
      : super(
          const SettingPassCodeAndBiometricState(),
        ) {
    _init();
  }

  Future<bool> requestBioMetric()async{
    final bool canRequestBio =
        await _appSecureUseCase.canAuthenticateWithBiometrics();

    if (canRequestBio) {
      return _appSecureUseCase.requestBiometric();
    }

    return canRequestBio;
  }


  void _init() async {
    final bool alReadySetBio = await _appSecureUseCase.isEnableBiometric(
      key: AppLocalConstant.bioMetricKey,
    );

    emit(state.copyWith(
      alReadySetBiometric: alReadySetBio,
    ));
  }

  void onSetBio() async {
    emit(state.copyWith(
      alReadySetBiometric: !state.alReadySetBiometric,
    ));
  }

  void updateBio(bool alReadySetBiometric) async {
    await _appSecureUseCase.enableBiometrics(
      key: AppLocalConstant.bioMetricKey,
      setBioValue: alReadySetBiometric,
    );
  }
}

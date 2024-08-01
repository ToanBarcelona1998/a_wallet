import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppSecureUseCase _appSecureUseCase;
  final AccountUseCase _accountUseCase;

  SplashCubit(
      this._appSecureUseCase,
      this._accountUseCase,
      ) : super(
    const SplashState(),
  );

  Future<void> starting() async {
    emit(state.copyWith(
      status: SplashStatus.starting,
    ));

    try {
      // Default status
      SplashStatus status = SplashStatus.notHasPassCodeOrError;

      final bool hasPassCode = await _appSecureUseCase.hasPasscode(
        key: AppLocalConstant.passCodeKey,
      );

      if (hasPassCode) {
        // if user set biometric. Check authentication by biometric. If user does not allow

        // user has passcode
        status = SplashStatus.hasPassCode;

        // check user set biometric
        final bool isReadySetAuthenticationByBiometric =
        await _appSecureUseCase.isEnableBiometric(
          key: AppLocalConstant.bioMetricKey,
        );

        // user has set biometric
        if (isReadySetAuthenticationByBiometric) {
          // check device can use bio
          final bool isSupportBio =
          await _appSecureUseCase.canAuthenticateWithBiometrics();

          // this device support biometric
          if (isSupportBio) {
            bool isVerify = await _appSecureUseCase.requestBiometric();

            final account = await _accountUseCase.getFirstAccount();

            // users verify successful
            if (isVerify && account != null) {
              status = SplashStatus.hasAccountAndVerifyByBioSuccessful;
            }
          }
        }
      }else{
        final account = await _accountUseCase.getFirstAccount();

        if(account != null){
          status = SplashStatus.notHasPassCodeAndHasAccount;
        }
      }

      emit(
        state.copyWith(status: status),
      );
    } catch (e) {
      emit(state.copyWith(
        status: SplashStatus.notHasPassCodeOrError,
      ));
    }
  }
}

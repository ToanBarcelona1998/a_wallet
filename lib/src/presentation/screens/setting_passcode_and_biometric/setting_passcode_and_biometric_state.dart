import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_passcode_and_biometric_state.freezed.dart';

@freezed
class SettingPassCodeAndBiometricState with _$SettingPassCodeAndBiometricState {
  const factory SettingPassCodeAndBiometricState({
    @Default(false) bool alReadySetBiometric,
  }) = _SettingPassCodeAndBiometricState;
}

import 'package:freezed_annotation/freezed_annotation.dart';
part 'setting_change_passcode_state.freezed.dart';

enum SettingChangePassCodeStatus {
  none,
  enterPasscodeSuccessful,
  enterPasscodeWrong,
  createNewPassCodeDone,
  confirmPassCodeSuccessful,
  confirmPasscodeWrong
}

@freezed
class SettingChangePasscodeState with _$SettingChangePasscodeState {
  const factory SettingChangePasscodeState({
    @Default(SettingChangePassCodeStatus.none)
    SettingChangePassCodeStatus status,
    @Default([]) List<String> passCodes,
  }) = _SettingChangePasscodeState;
}

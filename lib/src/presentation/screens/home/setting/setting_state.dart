import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_state.freezed.dart';

enum SettingStatus {
  none,
  onLogout,
  logoutDone,
}

@freezed
class SettingState with _$SettingState {
  const factory SettingState({
    @Default('') String currentLanguage,
    @Default([]) List<String> languages,
    @Default(SettingStatus.none) SettingStatus status,
  }) = _SettingState;
}

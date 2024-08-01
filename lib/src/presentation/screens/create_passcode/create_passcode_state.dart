import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_passcode_state.freezed.dart';

enum CreatePasscodeStatus {
  init,
  onSavePasscode,
  savePasscodeDone,
}

@freezed
class CreatePasscodeState with _$CreatePasscodeState {
  const factory CreatePasscodeState({
    @Default(CreatePasscodeStatus.init)
    CreatePasscodeStatus status,
  }) = _CreatePasscodeState;
}

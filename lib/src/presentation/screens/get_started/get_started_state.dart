import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'get_started_state.freezed.dart';

enum GetStartedStatus {
  none,
  onSocialLogin,
  loginSuccess,
  loginFailure,
}

@freezed
class GetStartedState with _$GetStartedState {
  const factory GetStartedState({
    @Default(GetStartedStatus.none) GetStartedStatus status,
    AWallet ?wallet,
    String ?error,
  }) = _GetStartedState;
}

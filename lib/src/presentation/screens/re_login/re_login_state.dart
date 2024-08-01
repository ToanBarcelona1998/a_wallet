import 'package:freezed_annotation/freezed_annotation.dart';

part 're_login_state.freezed.dart';

enum ReLoginStatus {
  none,
  wrongPassword,
  lockTime,
  hasAccounts,
  nonHasAccounts,
}

@freezed
class ReLoginState with _$ReLoginState {
  const factory ReLoginState({
    @Default(ReLoginStatus.none) ReLoginStatus status,
    @Default(10) int wrongCountDown,
  }) = _ReLoginState;
}
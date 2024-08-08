import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_state.freezed.dart';

enum SplashStatus {
  starting,
  hasPassCode,
  hasAccountAndVerifyByBioSuccessful,
  notHasPassCodeAndHasAccount,
  notHasPassCodeOrError,
}

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.starting) SplashStatus status,
  }) = _SplashState;
}

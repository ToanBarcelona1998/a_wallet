import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'social_login_yeti_bot_state.freezed.dart';

enum SocialLoginYetiBotStatus {
  none,
  storing,
  stored,
}

@freezed
class SocialLoginYetiBotState with _$SocialLoginYetiBotState {
  const factory SocialLoginYetiBotState({
    @Default(SocialLoginYetiBotStatus.none) SocialLoginYetiBotStatus status,
    required AWallet wallet,
    @Default(false) bool isReady,
  }) = _SocialLoginYetiBotState;
}

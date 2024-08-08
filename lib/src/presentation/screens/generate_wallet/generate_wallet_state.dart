import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'generate_wallet_state.freezed.dart';

enum GenerateWalletStatus {
  generating,
  generated,
  storing,
  stored,
}

@freezed
class GenerateWalletState with _$GenerateWalletState {
  const factory GenerateWalletState({
    @Default(GenerateWalletStatus.generating) GenerateWalletStatus status,
    AWallet ?wallet,
    @Default(false) bool isReady,
  }) = _GenerateWalletState;
}

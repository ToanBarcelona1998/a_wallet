import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'import_wallet_state.freezed.dart';

enum ImportWalletStatus {
  none,
  isReadySubmit,
  importing,
  imported,
}

@freezed
class ImportWalletState with _$ImportWalletState {
  const factory ImportWalletState({
    @Default(ImportWalletStatus.none) ImportWalletStatus status,
    @Default('') String controllerKey,
    @Default(ControllerKeyType.passPhrase) ControllerKeyType controllerType,
    @Default(12) int wordCount,
    AWallet ?aWallet,
  }) = _ImportWalletState;
}

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signed_import_wallet_state.freezed.dart';

enum SignedImportWalletStatus {
  none,
  isReadySubmit,
  importing,
  imported,
}

@freezed
class SignedImportWalletState with _$SignedImportWalletState {
  const factory SignedImportWalletState({
    @Default(SignedImportWalletStatus.none) SignedImportWalletStatus status,
    @Default('') String controllerKey,
    @Default(ControllerKeyType.passPhrase) ControllerKeyType controllerType,
    @Default(12) int wordCount,
    @Default('') String walletName,
    @Default([]) List<Account> accounts,
  }) = _SignedImportWalletState;
}

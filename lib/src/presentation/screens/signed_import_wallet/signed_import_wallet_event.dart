import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signed_import_wallet_event.freezed.dart';

@freezed
class SignedImportWalletEvent with _$SignedImportWalletEvent {
  const factory SignedImportWalletEvent.onInit() = SignedImportWalletOnInitEvent;

  const factory SignedImportWalletEvent.changeType({
    required ControllerKeyType type,
  }) = SignedImportWalletOnChangeTypeEvent;

  const factory SignedImportWalletEvent.changeWordCount({
    required int wordCount,
  }) = SignedImportWalletOnChangeWordCountEvent;

  const factory SignedImportWalletEvent.changeControllerKey({
    required String controllerKey,
  }) = SignedImportWalletOnControllerKeyChangeEvent;

  const factory SignedImportWalletEvent.changeWalletName({
    required String walletName,
  }) = SignedImportWalletOnWalletNameChangeEvent;

  const factory SignedImportWalletEvent.onSubmit() = SignedImportWalletOnSubmitEvent;
}

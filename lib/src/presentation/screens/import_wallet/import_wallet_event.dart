import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'import_wallet_event.freezed.dart';

@freezed
class ImportWalletEvent with _$ImportWalletEvent {
  const factory ImportWalletEvent.changeType({
    required ControllerKeyType type,
  }) = ImportWalletOnChangeTypeEvent;

  const factory ImportWalletEvent.changeWordCount({
    required int wordCount,
  }) = ImportWalletOnChangeWordCountEvent;

  const factory ImportWalletEvent.changeControllerKey({
    required String controllerKey,
  }) = ImportWalletOnControllerKeyChangeEvent;

  const factory ImportWalletEvent.onSubmit() = ImportWalletOnSubmitEvent;
}

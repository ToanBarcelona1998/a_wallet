import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_transfer_nft_event.freezed.dart';

@freezed
class ConfirmTransferNftEvent with _$ConfirmTransferNftEvent {
  const factory ConfirmTransferNftEvent.init() = ConfirmTransferNftOnInitEvent;

  const factory ConfirmTransferNftEvent.onChangeFee({
    required double gasPrice,
  }) = ConfirmTransferNftOnChangeFeeEvent;

  const factory ConfirmTransferNftEvent.onChangeIsShowedMessage() =
      ConfirmTransferNftOnChangeIsShowedMessageEvent;

  const factory ConfirmTransferNftEvent.onSubmit() =
      ConfirmTransferNftOnSubmitEvent;
}

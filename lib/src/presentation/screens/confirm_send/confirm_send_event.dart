import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_send_event.freezed.dart';

@freezed
class ConfirmSendEvent with _$ConfirmSendEvent {
  const factory ConfirmSendEvent.init() = ConfirmSendOnInitEvent;

  const factory ConfirmSendEvent.onChangeFee({required double gasPrice,}) =
      ConfirmSendOnChangeFeeEvent;

  const factory ConfirmSendEvent.onChangeIsShowedMessage() = ConfirmSendOnChangeIsShowedMessageEvent;
  const factory ConfirmSendEvent.onSubmit() = ConfirmSendOnSubmitEvent;
}

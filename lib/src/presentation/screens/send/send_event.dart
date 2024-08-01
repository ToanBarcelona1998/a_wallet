import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_event.freezed.dart';

@freezed
class SendEvent with _$SendEvent {
  const factory SendEvent.init() = SendOnInitEvent;

  const factory SendEvent.onChangeTo({
    required String address,
  }) = SendOnChangeToEvent;

  const factory SendEvent.onChangeAmount({
    required String amount,
  }) = SendOnChangeAmountEvent;

  const factory SendEvent.changeSaved() = SendOnChangeSavedEvent;

  const factory SendEvent.onChangeNetwork(AppNetwork network) = SendOnChangeNetworkEvent;


  const factory SendEvent.onChangeToken(Balance token) = SendOnChangeTokenEvent;
}

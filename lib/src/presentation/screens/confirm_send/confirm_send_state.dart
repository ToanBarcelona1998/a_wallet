import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_send_state.freezed.dart';

enum ConfirmSendStatus {
  init,
  sending,
  sent,
  error,
}

@freezed
class ConfirmSendState with _$ConfirmSendState {
  const factory ConfirmSendState({
    @Default(ConfirmSendStatus.init) ConfirmSendStatus status,
    String? error,
    @Default(false) bool isShowFullMsg,
    @Default({}) Map<String,dynamic> msg,
    @Default('') String hash,
    @Default('') String timeStamp,
    @Default([]) List<Token> tokens,
    required AppNetwork appNetwork,
    required Account account,
    required String amount,
    required String recipient,
    required Balance balance,
    required BigInt gasEstimation,
    required BigInt gasPrice,
    required BigInt gasPriceToSend,
  }) = _ConfirmSendState;
}

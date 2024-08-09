import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_transfer_nft_state.freezed.dart';

enum ConfirmTransferNftStatus {
  init,
  sending,
  sent,
  error,
}

@freezed
class ConfirmTransferNftState with _$ConfirmTransferNftState {
  const factory ConfirmTransferNftState({
    @Default(ConfirmTransferNftStatus.init) ConfirmTransferNftStatus status,
    String? error,
    @Default(false) bool isShowFullMsg,
    @Default({}) Map<String, dynamic> msg,
    @Default('') String hash,
    @Default('') String timeStamp,
    required NFTInformation nft,
    required AppNetwork appNetwork,
    required Account account,
    required String recipient,
    required BigInt gasEstimation,
    required BigInt gasPrice,
    required BigInt gasPriceToSend,
  }) = _ConfirmTransferNftState;
}

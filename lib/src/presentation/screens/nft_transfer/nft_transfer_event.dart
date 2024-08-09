import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_transfer_event.freezed.dart';

@freezed
class NftTransferEvent with _$NftTransferEvent {
  const factory NftTransferEvent.init() = NftTransferOnInitEvent;

  const factory NftTransferEvent.onChangeTo({
    required String address,
  }) = NftTransferOnChangeToEvent;
}

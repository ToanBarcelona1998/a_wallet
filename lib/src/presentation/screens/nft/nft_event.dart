import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_event.freezed.dart';

@freezed
class NFTEvent with _$NFTEvent {
  const factory NFTEvent.onInit() = NFTEventOnInit;

  const factory NFTEvent.onLoadMore() = NFTEventOnLoadMore;

  const factory NFTEvent.onRefresh() = NFTEventOnRefresh;

  const factory NFTEvent.onSwitchType({
    required NFTLayoutType type,
  }) = NFTEventOnSwitchViewType;
}

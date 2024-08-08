import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_state.freezed.dart';

enum NFTStatus {
  loading,
  loaded,
  loadMore,
  refresh,
  error,
}

@freezed
class NFTState with _$NFTState {
  const factory NFTState({
    @Default(NFTStatus.loading) NFTStatus status,
    @Default(false) bool canLoadMore,
    @Default(0) int totalNFT,
    @Default([]) List<NFTInformation> nFTs,
    String ?error,
    @Default(NFTLayoutType.grid) NFTLayoutType viewType,
    @Default(20) int limit,
    @Default(0) int offset,
    @Default('') String owner,
  }) = _NFTState;
}

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'nft_transfer_state.freezed.dart';

enum NftTransferStatus{
  loading,
  loaded,
  error,
}


@freezed
class NftTransferState with _$NftTransferState {
  const factory NftTransferState({
    @Default(NftTransferStatus.loading) NftTransferStatus status,
    @Default(false) bool already,
    Account ?account,
    @Default([]) List<AddressBook> addressBooks,
    @Default('') String toAddress,
  }) = _NftTransferState;
}

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'nft_transfer_bloc.dart';
import 'nft_transfer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class NftTransferStatusSelector
    extends BlocSelector<NftTransferBloc, NftTransferState, NftTransferStatus> {
  NftTransferStatusSelector({
    super.key,
    required Widget Function(NftTransferStatus) builder,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class NftTransferAccountSelector
    extends BlocSelector<NftTransferBloc, NftTransferState, Account?> {
  NftTransferAccountSelector({
    super.key,
    required Widget Function(Account?) builder,
  }) : super(
          builder: (context, account) => builder(account),
          selector: (state) => state.account,
        );
}

final class NftTransferAddressBooksSelector
    extends BlocSelector<NftTransferBloc, NftTransferState, List<AddressBook>> {
  NftTransferAddressBooksSelector({
    super.key,
    required Widget Function(List<AddressBook>) builder,
  }) : super(
          builder: (context, addressBooks) => builder(addressBooks),
          selector: (state) => state.addressBooks,
        );
}

final class NftTransferAlreadySelector
    extends BlocSelector<NftTransferBloc, NftTransferState, bool> {
  NftTransferAlreadySelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          builder: (context, already) => builder(already),
          selector: (state) => state.already,
        );
}

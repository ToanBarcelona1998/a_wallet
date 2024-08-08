import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nft_bloc.dart';
import 'nft_state.dart';

final class NFTStatusSelector
    extends BlocSelector<NFTBloc, NFTState, NFTStatus> {
  NFTStatusSelector({
    super.key,
    required Widget Function(NFTStatus) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

final class NFTLayoutViewTypeSelector
    extends BlocSelector<NFTBloc, NFTState, NFTLayoutType> {
  NFTLayoutViewTypeSelector({
    super.key,
    required Widget Function(NFTLayoutType) builder,
  }) : super(
          selector: (state) => state.viewType,
          builder: (_, viewType) => builder(viewType),
        );
}

final class NFTCanLoadMoreSelector
    extends BlocSelector<NFTBloc, NFTState, bool> {
  NFTCanLoadMoreSelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          selector: (state) => state.canLoadMore,
          builder: (_, canLoadMore) => builder(canLoadMore),
        );
}

final class NFTInformationSSelector
    extends BlocSelector<NFTBloc, NFTState, List<NFTInformation>> {
  NFTInformationSSelector({
    super.key,
    required Widget Function(List<NFTInformation>) builder,
  }) : super(
          selector: (state) => state.nFTs,
          builder: (_, nFTs) => builder(nFTs),
        );
}

final class NFTTotalCountSelector
    extends BlocSelector<NFTBloc, NFTState, int> {
  NFTTotalCountSelector({
    super.key,
    required Widget Function(int) builder,
  }) : super(
          selector: (state) => state.totalNFT,
          builder: (_, totalNFT) => builder(totalNFT),
        );
}

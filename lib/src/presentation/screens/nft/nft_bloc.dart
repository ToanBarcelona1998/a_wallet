import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nft_event.dart';

import 'nft_state.dart';

final class NFTBloc extends Bloc<NFTEvent, NFTState> {
  final NftUseCase _nftUseCase;
  final AccountUseCase _accountUseCase;
  final AWalletConfig config;

  NFTBloc(
    this._nftUseCase,
    this._accountUseCase, {
    required this.config,
  }) : super(
          const NFTState(),
        ) {
    on(_init);
    on(_onRefresh);
    on(_onLoadMore);
    on(_onChangeViewType);
  }

  Future<List<NFTInformation>> _getNFTsInformation({
    String? owner,
  }) async {
    return _nftUseCase.queryNFTs(QueryERC721Request(
      owner: (owner ?? state.owner).toLowerCase(),
      environment: config.environment.environmentString,
      offset: state.offset,
      limit: state.limit,
    ));
  }

  void _init(
    NFTEventOnInit event,
    Emitter<NFTState> emit,
  ) async {
    emit(state.copyWith(
      status: NFTStatus.loading,
    ));

    try {
      final account = await _accountUseCase.getFirstAccount();

      emit(
        state.copyWith(
          owner: account?.evmAddress ?? '',
        ),
      );

      final List<NFTInformation> nftS = await _getNFTsInformation(
        owner: account?.evmAddress,
      );

      emit(
        state.copyWith(
          owner: account?.evmAddress ?? '',
          status: NFTStatus.loaded,
          nFTs: nftS,
          totalNFT: nftS.length,
          canLoadMore: nftS.length >= state.limit,
        ),
      );
    } catch (e) {
      LogProvider.log('Fetch NFTs error ${e.toString()}');
      emit(state.copyWith(
        status: NFTStatus.error,
        error: e.toString(),
      ));
    }
  }

  void _onLoadMore(
    NFTEventOnLoadMore event,
    Emitter<NFTState> emit,
  ) async {
    if (state.status != NFTStatus.loaded) return;

    emit(
      state.copyWith(
        status: NFTStatus.loadMore,
        offset: state.offset + 20,
      ),
    );

    try {
      final List<NFTInformation> nftS = await _getNFTsInformation();

      emit(
        state.copyWith(
          status: NFTStatus.loaded,
          nFTs: [
            ...state.nFTs,
            ...nftS,
          ],
          totalNFT: nftS.length,
          canLoadMore: nftS.length >= state.limit,
        ),
      );
    } catch (e) {
      LogProvider.log('Fetch NFTs error ${e.toString()}');
      emit(state.copyWith(
        status: NFTStatus.error,
        error: e.toString(),
      ));
    }
  }

  void _onRefresh(
    NFTEventOnRefresh event,
    Emitter<NFTState> emit,
  ) async {
    if (state.status != NFTStatus.loaded) return;

    emit(
      state.copyWith(
        status: NFTStatus.refresh,
        nFTs: [],
        offset: 0,
      ),
    );
    try {
      final List<NFTInformation> nftS = await _getNFTsInformation();

      emit(
        state.copyWith(
          status: NFTStatus.loaded,
          nFTs: nftS,
          totalNFT: nftS.length,
          canLoadMore: nftS.length >= state.limit,
        ),
      );
    } catch (e) {
      LogProvider.log('Fetch NFTs error ${e.toString()}');
      emit(state.copyWith(
        status: NFTStatus.error,
        error: e.toString(),
      ));
    }
  }

  void _onChangeViewType(
    NFTEventOnSwitchViewType event,
    Emitter<NFTState> emit,
  ) {
    emit(
      state.copyWith(
        viewType: event.type,
        status: NFTStatus.loaded,
      ),
    );
  }

  static NFTBloc of(BuildContext context) => BlocProvider.of<NFTBloc>(context);
}

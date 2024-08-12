import 'dart:typed_data';

import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:wallet_core/wallet_core.dart';

import 'confirm_transfer_nft_event.dart';
import 'confirm_transfer_nft_state.dart';

final class ConfirmTransferNftBloc
    extends Bloc<ConfirmTransferNftEvent, ConfirmTransferNftState> {
  final AWalletConfig config;
  final KeyStoreUseCase _keyStoreUseCase;

  ConfirmTransferNftBloc(
    this._keyStoreUseCase, {
    required this.config,
    required AppNetwork appNetwork,
    required Account account,
    required String recipient,
    required NFTInformation nft,
  })  : _evmChainClient = EvmChainClient(
          config.environment.evmChainInfo,
        ),
        super(
          ConfirmTransferNftState(
            appNetwork: appNetwork,
            account: account,
            recipient: recipient,
            gasEstimation: BigInt.zero,
            gasPrice: BigInt.zero,
            gasPriceToSend: BigInt.zero,
            nft: nft,
          ),
        ) {
    on(_onInit);
    on(_onSubmit);
    on(_onChangeFee);
    on(_onChangeIsShowedMsg);
  }

  final EvmChainClient _evmChainClient;

  void _onInit(
    ConfirmTransferNftOnInitEvent event,
    Emitter<ConfirmTransferNftState> emit,
  ) async {
    try {
      BigInt gasPrice = TokenType.native.formatBalanceToInt(
        config.config.evmInfo.gasPriceStep.average.toString(),
      );

      emit(
        state.copyWith(
          gasPrice: gasPrice,
          gasPriceToSend: gasPrice,
        ),
      );

      final KeyStore? keyStore =
          await _keyStoreUseCase.get(state.account.keyStoreId);

      final AWallet? aWallet = WalletCore.storedManagement.fromSavedJson(
        keyStore?.key ?? '',
        '',
        coinType: state.appNetwork.coinType,
      );

      BigInt gasEstimation = BigInt.zero;

      Map<String, dynamic> msg = createERC721TransferTransaction(
        privateKey: aWallet!.privateKeyData,
        chainId: BigInt.from(config.config.evmInfo.chainId),
        gasLimit: BigInt.from(100000),
        recipient: state.recipient,
        gasPrice: gasPrice,
        nonce: BigInt.zero,
        tokenId: BigInt.from(
          int.parse(
            state.nft.tokenId,
          ),
        ),
        contractAddress: state.nft.cw721Contract.smartContract.address,
        from: aWallet.address,
      ).writeToJsonMap();

      emit(state.copyWith(
        msg: msg,
      ));

      gasEstimation = await _evmChainClient.estimateGas(
        sender: aWallet.address,
        recipient: state.recipient,
        amount: BigInt.zero,
      );

      gasPrice = _transformGasPrice(gasPrice);

      emit(
        state.copyWith(
          gasEstimation: gasEstimation,
          gasPrice: gasPrice,
          gasPriceToSend: gasPrice,
          msg: msg,
        ),
      );
    } catch (e) {
      LogProvider.log('Confirm send init error ${e.toString()}');
    }
  }

  void _onChangeFee(
    ConfirmTransferNftOnChangeFeeEvent event,
    Emitter<ConfirmTransferNftState> emit,
  ) async {
    emit(
      state.copyWith(
        gasPriceToSend: BigInt.from(event.gasPrice),
      ),
    );
  }

  void _onChangeIsShowedMsg(
    ConfirmTransferNftOnChangeIsShowedMessageEvent event,
    Emitter<ConfirmTransferNftState> emit,
  ) async {
    emit(state.copyWith(
      status: ConfirmTransferNftStatus.init,
      isShowFullMsg: !state.isShowFullMsg,
    ));
  }

  void _onSubmit(
    ConfirmTransferNftOnSubmitEvent event,
    Emitter<ConfirmTransferNftState> emit,
  ) async {
    emit(state.copyWith(
      status: ConfirmTransferNftStatus.sending,
    ));

    final KeyStore? keyStore =
        await _keyStoreUseCase.get(state.account.keyStoreId);

    final AWallet? aWallet = WalletCore.storedManagement.fromSavedJson(
      keyStore?.key ?? '',
      '',
      coinType: state.appNetwork.coinType,
    );

    try {
      final evmTransaction = await _evmChainClient.createErc721Transaction(
        wallet: aWallet!,
        contractAddress: state.nft.cw721Contract.smartContract.address,
        tokenId: BigInt.from(
          int.parse(
            state.nft.tokenId,
          ),
        ),
        gasLimit: BigInt.from(100000),
        recipient: state.recipient,
        gasPrice: state.gasPriceToSend,
      );

      final String hash = await _evmChainClient.sendTransaction(
        rawTransaction: Uint8List.fromList(evmTransaction.encoded),
      );

      LogProvider.log('receive hash $hash');

      await _evmChainClient.verifyTransaction(hash: hash);

      emit(state.copyWith(
        status: ConfirmTransferNftStatus.sent,
        hash: hash,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ConfirmTransferNftStatus.error,
        error: e.toString(),
      ));
      LogProvider.log('Confirm transfer nft submit transaction error ${e.toString()}');
    }
  }

  BigInt _transformGasPrice(BigInt gasPrice) {
    BigInt lowGasPrice = TokenType.native.formatBalanceToInt(
      config.config.evmInfo.gasPriceStep.low.toString(),
    );

    if (gasPrice < lowGasPrice) {
      return lowGasPrice;
    }

    return gasPrice;
  }
}

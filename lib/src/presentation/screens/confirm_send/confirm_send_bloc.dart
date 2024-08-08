import 'dart:typed_data';

import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:wallet_core/wallet_core.dart';

import 'confirm_send_event.dart';
import 'confirm_send_state.dart';

final class ConfirmSendBloc extends Bloc<ConfirmSendEvent, ConfirmSendState> {
  final AWalletConfig config;
  final KeyStoreUseCase _keyStoreUseCase;

  ConfirmSendBloc(
    this._keyStoreUseCase, {
    required this.config,
    required AppNetwork appNetwork,
    required Account account,
    required String amount,
    required String recipient,
    required Balance balance,
    required List<Token> tokens,
  })  : _evmChainClient = EvmChainClient(
          config.environment.evmChainInfo,
        ),
        super(
          ConfirmSendState(
            appNetwork: appNetwork,
            account: account,
            amount: amount,
            recipient: recipient,
            balance: balance,
            gasEstimation: BigInt.zero,
            gasPrice: BigInt.zero,
            gasPriceToSend: BigInt.zero,
            tokens: tokens,
          ),
        ) {
    on(_onInit);
    on(_onSubmit);
    on(_onChangeFee);
    on(_onChangeIsShowedMsg);
  }

  final EvmChainClient _evmChainClient;

  void _onInit(
    ConfirmSendOnInitEvent event,
    Emitter<ConfirmSendState> emit,
  ) async {
    try {
      final token = state.tokens.firstWhereOrNull(
        (t) => t.id == state.balance.tokenId,
      );

      BigInt gasPrice = token!.type.formatBalanceToInt(
        config.config.evmInfo.gasPriceStep.average.toString(),
        customDecimal: token.decimal,
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

      final BigInt amount = token.type
          .formatBalanceToInt(state.amount, customDecimal: token.decimal);

      BigInt gasEstimation = BigInt.zero;

      Map<String, dynamic> msg = {};

      switch (state.appNetwork.type) {
        case AppNetworkType.evm:
          gasPrice = await _evmChainClient.getGasPrice();

          emit(state.copyWith(
            gasPrice: _transformGasPrice(gasPrice, token),
          ));

          switch (token.type) {
            case TokenType.native:
              msg = createEvmTransferTransaction(
                privateKey: aWallet!.privateKeyData,
                chainId: BigInt.from(config.config.evmInfo.chainId),
                amount: amount,
                gasLimit: BigInt.from(21000),
                recipient: state.recipient,
                gasPrice: gasPrice,
                nonce: BigInt.zero,
              ).writeToJsonMap();

              emit(
                state.copyWith(
                  msg: msg,
                ),
              );

              gasEstimation = await _evmChainClient.estimateGas(
                sender: aWallet.address,
                recipient: state.recipient,
                amount: amount,
              );
              break;
            case TokenType.erc20:
              final erc20Tran = createErc20TransferTransaction(
                privateKey: aWallet!.privateKeyData,
                chainId: BigInt.from(config.config.evmInfo.chainId),
                amount: amount,
                gasLimit: BigInt.from(65000),
                recipient: state.recipient,
                gasPrice: gasPrice,
                nonce: BigInt.zero,
                contractAddress: token.contractAddress,
              );

              gasEstimation = await _evmChainClient.estimateGas(
                sender: aWallet.address,
                recipient: state.recipient,
                amount: amount,
                data: hexToBytes(
                  token.contractAddress,
                ),
              );

              msg = erc20Tran.writeToJsonMap();

              emit(
                state.copyWith(
                  msg: msg,
                ),
              );

              break;
            default:
              break;
          }
          break;
        case AppNetworkType.other:
          // Currently, Pick wallet don't support this type
          break;
      }

      gasPrice = _transformGasPrice(gasPrice, token);

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
    ConfirmSendOnChangeFeeEvent event,
    Emitter<ConfirmSendState> emit,
  ) async {
    emit(
      state.copyWith(
        gasPriceToSend: BigInt.from(event.gasPrice),
      ),
    );
  }

  void _onChangeIsShowedMsg(
    ConfirmSendOnChangeIsShowedMessageEvent event,
    Emitter<ConfirmSendState> emit,
  ) async {
    emit(state.copyWith(
      status: ConfirmSendStatus.init,
      isShowFullMsg: !state.isShowFullMsg,
    ));
  }

  void _onSubmit(
    ConfirmSendOnSubmitEvent event,
    Emitter<ConfirmSendState> emit,
  ) async {
    emit(state.copyWith(
      status: ConfirmSendStatus.sending,
    ));

    final KeyStore? keyStore =
        await _keyStoreUseCase.get(state.account.keyStoreId);

    final AWallet? aWallet = WalletCore.storedManagement.fromSavedJson(
      keyStore?.key ?? '',
      '',
      coinType: state.appNetwork.coinType,
    );

    final token = state.tokens.firstWhereOrNull(
      (t) => t.id == state.balance.tokenId,
    );

    try {
      switch (state.appNetwork.type) {
        case AppNetworkType.evm:
          switch (token!.type) {
            case TokenType.native:
              final evmTransaction =
                  await _evmChainClient.createTransferTransaction(
                wallet: aWallet!,
                amount: token.type.formatBalanceToInt(
                  state.amount,
                  customDecimal: token.decimal,
                ),
                gasLimit: BigInt.from(21000),
                recipient: state.recipient,
                gasPrice: state.gasPriceToSend,
              );

              final String hash = await _evmChainClient.sendTransaction(
                rawTransaction: Uint8List.fromList(evmTransaction.encoded),
              );

              LogProvider.log('receive hash $hash');

              await _evmChainClient.verifyTransaction(hash: hash);

              emit(state.copyWith(
                status: ConfirmSendStatus.sent,
                hash: hash,
              ));
              break;
            case TokenType.erc20:
              final erc20Transaction =
                  await _evmChainClient.createErc20Transaction(
                wallet: aWallet!,
                amount: token.type.formatBalanceToInt(
                  state.amount,
                  customDecimal: token.decimal,
                ),
                gasLimit: BigInt.from(65000),
                recipient: state.recipient,
                gasPrice: state.gasPriceToSend,
                contractAddress: token.contractAddress,
              );

              final String hash = await _evmChainClient.sendTransaction(
                rawTransaction: Uint8List.fromList(erc20Transaction.encoded),
              );

              LogProvider.log('receive hash $hash');

              await _evmChainClient.verifyTransaction(hash: hash);

              emit(state.copyWith(
                status: ConfirmSendStatus.sent,
                hash: hash,
              ));
              break;
            default:
              break;
          }
          break;
        case AppNetworkType.other:
          break;
      }
    } catch (e) {
      emit(state.copyWith(
        status: ConfirmSendStatus.error,
        error: e.toString(),
      ));
      LogProvider.log('Confirm send submit transaction error ${e.toString()}');
    }
  }

  BigInt _transformGasPrice(BigInt gasPrice, Token token) {
    BigInt lowGasPrice = token.type.formatBalanceToInt(
      config.config.evmInfo.gasPriceStep.low.toString(),
      customDecimal: token.decimal,
    );

    if (gasPrice < lowGasPrice) {
      return lowGasPrice;
    }

    return gasPrice;
  }
}

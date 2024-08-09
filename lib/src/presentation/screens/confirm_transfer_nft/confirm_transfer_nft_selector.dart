import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'confirm_send_bloc.dart';
import 'confirm_transfer_nft_state.dart';

final class ConfirmTransferNftGasEstimationSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, BigInt> {
  ConfirmTransferNftGasEstimationSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasEstimation) => builder(gasEstimation),
          selector: (state) => state.gasEstimation,
        );
}

final class ConfirmTransferNftGasPriceSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, BigInt> {
  ConfirmTransferNftGasPriceSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasPrice) => builder(gasPrice),
          selector: (state) => state.gasPrice,
        );
}

final class ConfirmTransferNftGasPriceToSendSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, BigInt> {
  ConfirmTransferNftGasPriceToSendSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasPriceToSend) => builder(gasPriceToSend),
          selector: (state) => state.gasPriceToSend,
        );
}

final class ConfirmTransferNftStatusSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, ConfirmTransferNftStatus> {
  ConfirmTransferNftStatusSelector({
    required Widget Function(ConfirmTransferNftStatus) builder,
    super.key,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class ConfirmTransferNftIsShowedFullMessageSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, bool> {
  ConfirmTransferNftIsShowedFullMessageSelector({
    required Widget Function(bool) builder,
    super.key,
  }) : super(
          builder: (context, isShowedFullMsg) => builder(isShowedFullMsg),
          selector: (state) => state.isShowFullMsg,
        );
}

final class ConfirmTransferNftMsgSelector
    extends BlocSelector<ConfirmTransferNftBloc, ConfirmTransferNftState, Map<String,dynamic>> {
  ConfirmTransferNftMsgSelector({
    required Widget Function(Map<String,dynamic>) builder,
    super.key,
  }) : super(
          builder: (context, msg) => builder(msg),
          selector: (state) => state.msg,
        );
}

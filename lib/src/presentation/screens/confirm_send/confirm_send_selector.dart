import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/presentation/screens/confirm_send/confirm_send_bloc.dart';

import 'confirm_send_state.dart';

final class ConfirmSendGasEstimationSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, BigInt> {
  ConfirmSendGasEstimationSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasEstimation) => builder(gasEstimation),
          selector: (state) => state.gasEstimation,
        );
}

final class ConfirmSendGasPriceSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, BigInt> {
  ConfirmSendGasPriceSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasPrice) => builder(gasPrice),
          selector: (state) => state.gasPrice,
        );
}

final class ConfirmSendGasPriceToSendSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, BigInt> {
  ConfirmSendGasPriceToSendSelector({
    required Widget Function(BigInt) builder,
    super.key,
  }) : super(
          builder: (context, gasPriceToSend) => builder(gasPriceToSend),
          selector: (state) => state.gasPriceToSend,
        );
}

final class ConfirmSendStatusSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, ConfirmSendStatus> {
  ConfirmSendStatusSelector({
    required Widget Function(ConfirmSendStatus) builder,
    super.key,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class ConfirmSendIsShowedFullMessageSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, bool> {
  ConfirmSendIsShowedFullMessageSelector({
    required Widget Function(bool) builder,
    super.key,
  }) : super(
          builder: (context, isShowedFullMsg) => builder(isShowedFullMsg),
          selector: (state) => state.isShowFullMsg,
        );
}

final class ConfirmSendMsgSelector
    extends BlocSelector<ConfirmSendBloc, ConfirmSendState, Map<String,dynamic>> {
  ConfirmSendMsgSelector({
    required Widget Function(Map<String,dynamic>) builder,
    super.key,
  }) : super(
          builder: (context, msg) => builder(msg),
          selector: (state) => state.msg,
        );
}

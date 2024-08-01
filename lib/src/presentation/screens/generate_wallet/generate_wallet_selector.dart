import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generate_wallet_cubit.dart';
import 'generate_wallet_state.dart';

final class GenerateWalletIsReadySelector
    extends BlocSelector<GenerateWalletCubit, GenerateWalletState, bool> {
  GenerateWalletIsReadySelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          selector: (state) => state.isReady,
          builder: (context, isReady) => builder(isReady),
        );
}

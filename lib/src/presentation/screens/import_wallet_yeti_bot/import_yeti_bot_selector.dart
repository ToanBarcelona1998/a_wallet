import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'import_wallet_yeti_bot_state.dart';

import 'import_wallet_yeti_bot_cubit.dart';

final class ImportWalletYetiBotIsReadySelector
    extends BlocSelector<ImportWalletYetiBotCubit, ImportWalletYetiBotState, bool> {
  ImportWalletYetiBotIsReadySelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
    selector: (state) => state.isReady,
    builder: (context, isReady) => builder(isReady),
  );
}
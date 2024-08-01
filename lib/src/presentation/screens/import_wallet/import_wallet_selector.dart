import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'import_wallet_bloc.dart';
import 'import_wallet_state.dart';

final class ImportWalletStatusSelector extends BlocSelector<ImportWalletBloc,
    ImportWalletState, ImportWalletStatus> {
  ImportWalletStatusSelector({
    super.key,
    required Widget Function(ImportWalletStatus) builder,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class ImportWalletControllerKeyTypeSelector extends BlocSelector<
    ImportWalletBloc, ImportWalletState, ControllerKeyType> {
  ImportWalletControllerKeyTypeSelector({
    super.key,
    required Widget Function(ControllerKeyType) builder,
  }) : super(
          builder: (context, controllerType) => builder(controllerType),
          selector: (state) => state.controllerType,
        );
}

final class ImportWalletWordCountSelector extends BlocSelector<
    ImportWalletBloc, ImportWalletState, int> {
  ImportWalletWordCountSelector({
    super.key,
    required Widget Function(int) builder,
  }) : super(
          builder: (context, wordCount) => builder(wordCount),
          selector: (state) => state.wordCount,
        );
}

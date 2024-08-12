import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signed_import_wallet_bloc.dart';
import 'signed_import_wallet_state.dart';

final class SignedImportWalletStatusSelector extends BlocSelector<SignedImportWalletBloc,
    SignedImportWalletState, SignedImportWalletStatus> {
  SignedImportWalletStatusSelector({
    super.key,
    required Widget Function(SignedImportWalletStatus) builder,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class SignedImportWalletControllerKeyTypeSelector extends BlocSelector<
    SignedImportWalletBloc, SignedImportWalletState, ControllerKeyType> {
  SignedImportWalletControllerKeyTypeSelector({
    super.key,
    required Widget Function(ControllerKeyType) builder,
  }) : super(
          builder: (context, controllerType) => builder(controllerType),
          selector: (state) => state.controllerType,
        );
}

final class SignedImportWalletWordCountSelector extends BlocSelector<
    SignedImportWalletBloc, SignedImportWalletState, int> {
  SignedImportWalletWordCountSelector({
    super.key,
    required Widget Function(int) builder,
  }) : super(
          builder: (context, wordCount) => builder(wordCount),
          selector: (state) => state.wordCount,
        );
}

final class SignedImportWalletAccountsSelector extends BlocSelector<
    SignedImportWalletBloc, SignedImportWalletState, List<Account>> {
  SignedImportWalletAccountsSelector({
    super.key,
    required Widget Function(List<Account>) builder,
  }) : super(
          builder: (context, accounts) => builder(accounts),
          selector: (state) => state.accounts,
        );
}

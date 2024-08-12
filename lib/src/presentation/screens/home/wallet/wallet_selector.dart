import 'package:domain/domain.dart';

import 'wallet_cubit.dart';
import 'wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class WalletStatusSelector
    extends BlocSelector<WalletCubit, WalletState, WalletStatus> {
  WalletStatusSelector({
    super.key,
    required Widget Function(WalletStatus) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (context, status) => builder(
            status,
          ),
        );
}

final class WalletAccountsSelector
    extends BlocSelector<WalletCubit, WalletState, List<Account>> {
  WalletAccountsSelector({
    super.key,
    required Widget Function(List<Account>) builder,
  }) : super(
          selector: (state) => state.accounts,
          builder: (context, accounts) => builder(
            accounts,
          ),
        );
}

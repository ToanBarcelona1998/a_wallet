import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_state.dart';

import 'browser_bloc.dart';

class BrowserAccountsSelector
    extends BlocSelector<BrowserBloc, BrowserState, List<Account>> {
  BrowserAccountsSelector({
    super.key,
    required Widget Function(List<Account>) builder,
  }) : super(
          selector: (state) => state.accounts,
          builder: (_, accounts) => builder(
            accounts,
          ),
        );
}

class BrowserSelectedAccountSelector
    extends BlocSelector<BrowserBloc, BrowserState, Account?> {
  BrowserSelectedAccountSelector({
    super.key,
    required Widget Function(Account?) builder,
  }) : super(
          selector: (state) => state.selectedAccount,
          builder: (_, selectedAccount) => builder(
            selectedAccount,
          ),
        );
}

class BrowserTabCountSelector
    extends BlocSelector<BrowserBloc, BrowserState, int> {
  BrowserTabCountSelector({
    super.key,
    required Widget Function(int) builder,
  }) : super(
          selector: (state) => state.tabCount,
          builder: (_, tabCount) => builder(
            tabCount,
          ),
        );
}

class BrowserBookMarkSelector
    extends BlocSelector<BrowserBloc, BrowserState, BookMark?> {
  BrowserBookMarkSelector({
    super.key,
    required Widget Function(BookMark?) builder,
  }) : super(
          selector: (state) => state.bookMark,
          builder: (_, bookMark) => builder(
            bookMark,
          ),
        );
}

class BrowserUrlSelector
    extends BlocSelector<BrowserBloc, BrowserState, String> {
  BrowserUrlSelector({
    super.key,
    required Widget Function(String) builder,
  }) : super(
          selector: (state) => state.currentUrl,
          builder: (_, currentUrl) => builder(
            currentUrl,
          ),
        );
}

class BrowserCanGoNextSelector
    extends BlocSelector<BrowserBloc, BrowserState, bool> {
  BrowserCanGoNextSelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          selector: (state) => state.canGoNext,
          builder: (_, canGoNext) => builder(
            canGoNext,
          ),
        );
}

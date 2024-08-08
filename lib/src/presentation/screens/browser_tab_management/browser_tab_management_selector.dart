import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_tab_management_state.dart';
import 'browser_tab_management_bloc.dart';

class BrowserTabManagementStatusSelector extends BlocSelector<
    BrowserTabManagementBloc,
    BrowserTabManagementState,
    BrowserTabManagementStatus> {
  BrowserTabManagementStatusSelector({
    Key? key,
    required Widget Function(BrowserTabManagementStatus) builder,
  }) : super(
          key: key,
          selector: (state) => state.status,
          builder: (_, status) => builder(
            status,
          ),
        );
}

class BrowserTabManagementBrowsersSelector extends BlocSelector<
    BrowserTabManagementBloc,
    BrowserTabManagementState,
    List<Browser>> {
  BrowserTabManagementBrowsersSelector({
    Key? key,
    required Widget Function(List<Browser>) builder,
  }) : super(
          key: key,
          selector: (state) => state.browsers,
          builder: (_, browsers) => builder(
            browsers,
          ),
        );
}

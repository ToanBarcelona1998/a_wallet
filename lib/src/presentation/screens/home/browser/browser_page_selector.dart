import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_page_bloc.dart';

import 'browser_page_state.dart';

final class BrowserPageTabSelector
    extends BlocSelector<BrowserPageBloc, BrowserPageState, int> {
  BrowserPageTabSelector({
    Key? key,
    required Widget Function(int) builder,
  }) : super(
          key: key,
          selector: (state) => state.currentTab,
          builder: (_, index) => builder(
            index,
          ),
        );
}
final class BrowserPageEcosystemsSelector
    extends BlocSelector<BrowserPageBloc, BrowserPageState, List<BookMark>> {
  BrowserPageEcosystemsSelector({
    Key? key,
    required Widget Function(List<BookMark>) builder,
  }) : super(
          key: key,
          selector: (state) => state.ecosystems,
          builder: (_, ecosystems) => builder(
            ecosystems,
          ),
        );
}
final class BrowserPageBookMarksSelector
    extends BlocSelector<BrowserPageBloc, BrowserPageState, List<BookMark>> {
  BrowserPageBookMarksSelector({
    Key? key,
    required Widget Function(List<BookMark>) builder,
  }) : super(
          key: key,
          selector: (state) => state.bookMarks,
          builder: (_, bookMarks) => builder(
            bookMarks,
          ),
        );
}

final class BrowserPageTabCountSelector
    extends BlocSelector<BrowserPageBloc, BrowserPageState, int> {
  BrowserPageTabCountSelector({
    Key? key,
    required Widget Function(int) builder,
  }) : super(
          key: key,
          selector: (state) => state.tabCount,
          builder: (_, tabCount) => builder(
            tabCount,
          ),
        );
}

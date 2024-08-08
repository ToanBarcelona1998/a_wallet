import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_search_state.dart';

import 'browser_search_bloc.dart';

class BrowserSearchSystemsSelector extends BlocSelector<BrowserSearchBloc,
    BrowserSearchState, List<BookMark>> {
  BrowserSearchSystemsSelector({
    Key? key,
    required Widget Function(List<BookMark>) builder,
  }) : super(
          key: key,
          selector: (state) => state.systems,
          builder: (_, systems) => builder(systems),
        );
}

class BrowserSearchQuerySelector extends BlocSelector<BrowserSearchBloc,
    BrowserSearchState, String> {
  BrowserSearchQuerySelector({
    Key? key,
    required Widget Function(String) builder,
  }) : super(
          key: key,
          selector: (state) => state.query,
          builder: (_, query) => builder(query),
        );
}

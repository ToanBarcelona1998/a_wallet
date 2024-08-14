import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'history_bloc.dart';
import 'history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HistoryStatusSelector
    extends BlocSelector<HistoryBloc, HistoryState, HistoryStatus> {
  HistoryStatusSelector({
    super.key,
    required Widget Function(HistoryStatus) builder,
  }) : super(
          builder: (context, status) => builder(status),
          selector: (state) => state.status,
        );
}

final class HistoryTransactionsSelector
    extends BlocSelector<HistoryBloc, HistoryState, List<Transaction>> {
  HistoryTransactionsSelector({
    super.key,
    required Widget Function(List<Transaction>) builder,
  }) : super(
          builder: (context, txs) => builder(txs),
          selector: (state) => state.transactions,
        );
}

final class HistoryFunctionMappingsSelector
    extends BlocSelector<HistoryBloc, HistoryState, List<FunctionMapping>> {
  HistoryFunctionMappingsSelector({
    super.key,
    required Widget Function(List<FunctionMapping>) builder,
  }) : super(
          builder: (context, functions) => builder(functions),
          selector: (state) => state.functions,
        );
}

final class HistoryCanLoadMoreSelector
    extends BlocSelector<HistoryBloc, HistoryState, bool> {
  HistoryCanLoadMoreSelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
          builder: (context, canLoadMore) => builder(canLoadMore),
          selector: (state) => state.canLoadMore,
        );
}

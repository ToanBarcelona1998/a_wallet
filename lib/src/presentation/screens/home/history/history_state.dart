import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.freezed.dart';

enum HistoryStatus {
  loading,
  loaded,
  loadMore,
  error,
}

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    Account? activeAccount,
    @Default(HistoryStatus.loading) HistoryStatus status,
    @Default([]) List<Transaction> transactions,
    @Default([]) List<FunctionMapping> functions,
    @Default(20) int limit,
    @Default(false) bool canLoadMore,
  }) = _HistoryState;
}

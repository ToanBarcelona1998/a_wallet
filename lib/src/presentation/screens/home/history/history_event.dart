import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.freezed.dart';

@freezed
class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.onInit() = HistoryOnInitEvent;

  const factory HistoryEvent.onRefresh() = HistoryOnRefreshEvent;

  const factory HistoryEvent.onLoadMore() = HistoryOnLoadMoreEvent;

  const factory HistoryEvent.onAccountChange(Account account) =
      HistoryOnChangeAccountEvent;
}

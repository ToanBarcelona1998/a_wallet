import 'package:a_wallet/src/core/observer/observer_base.dart';

typedef HistoryPageListener = void Function(HistoryPageEmitParam data);

final class HistoryPageEmitParam<T> {
  final String event;
  final T ?data;

  const HistoryPageEmitParam({
    required this.event,
    this.data,
  });
}

final class HistoryPageObserver
    extends ObserverBase<HistoryPageListener, HistoryPageEmitParam> {
  static const String onChangeAccount = 'HISTORY_PAGE_ON_CHANGE_ACCOUNT';

  @override
  void emit({
    required HistoryPageEmitParam emitParam,
  }) {
    for (final listener in listeners) {
      listener.call(emitParam);
    }
  }
}

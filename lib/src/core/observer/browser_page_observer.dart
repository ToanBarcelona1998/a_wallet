import 'package:a_wallet/src/core/observer/observer_base.dart';

typedef BrowserPageListener = void Function(BrowserPageEmitParam data);

final class BrowserPageEmitParam<T> {
  final String event;
  final T ?data;

  const BrowserPageEmitParam({
    required this.event,
    this.data,
  });
}

final class BrowserPageObserver
    extends ObserverBase<BrowserPageListener, BrowserPageEmitParam> {
  static const String onInAppBrowserRefreshBookMarkEvent = 'BROWSER_PAGE_ON_REFRESH_BOOK_MARK';
  static const String onInAppBrowserRefreshBrowserEvent = 'BROWSER_PAGE_ON_REFRESH_BROWSER';

  @override
  void emit({
    required BrowserPageEmitParam emitParam,
  }) {
    for (final listener in listeners) {
      listener.call(emitParam);
    }
  }
}

import 'observer_base.dart';

typedef HomePageListener = void Function(HomePageEmitParam data);

final class HomePageEmitParam<T> {
  final String event;
  final T ?data;

  const HomePageEmitParam({
    required this.event,
    this.data,
  });
}

final class HomePageObserver
    extends ObserverBase<HomePageListener, HomePageEmitParam> {

  static const String onSendTokenDone = 'HOME_PAGE_ON_SEND_TOKEN_DONE';
  static const String onSendNFTDone = 'HOME_PAGE_ON_SEND_ERC721_DONE';
  static const String onChangeAccount = 'HOME_PAGE_ON_CHANGE_ACCOUNT';
  static const String onMangedToken = 'HOME_PAGE_ON_MANAGED_TOKEN';

  @override
  void emit({
    required HomePageEmitParam emitParam,
  }) {
    for (final listener in listeners) {
      listener.call(emitParam);
    }
  }
}

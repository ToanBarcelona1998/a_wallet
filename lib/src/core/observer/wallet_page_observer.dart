import 'package:a_wallet/src/core/observer/observer_base.dart';

typedef WalletPageListener = void Function(String);

final class WalletPageObserver
    extends ObserverBase<WalletPageListener, String> {
  static const String onImportedAccount = 'WALLET_PAGE_ON_IMPORTED_ACCOUNT';

  @override
  void emit({
    required String emitParam,
  }) {
    for (final listener in listeners) {
      listener.call(emitParam);
    }
  }
}

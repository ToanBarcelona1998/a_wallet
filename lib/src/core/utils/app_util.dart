import 'package:domain/domain.dart';
import 'package:wallet_core/wallet_core.dart';

extension AppNetworkExtension on AppNetwork {
  int get coinType {
    // Change later
    switch (type) {
      case AppNetworkType.evm:
        return TWCoinType.TWCoinTypeEthereum;
      case AppNetworkType.other:
        return TWCoinType.TWCoinTypeEthereum;
    }
  }
}
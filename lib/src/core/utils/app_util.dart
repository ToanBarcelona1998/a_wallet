import 'package:domain/domain.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
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

  List<Balance> tokenWithType(List<Balance> balances,List<Token> tokens) {
    switch (type) {
      case AppNetworkType.evm:
        return balances
            .where(
              (e) {
                final token = tokens.firstWhereOrNull((t) => t.id == e.tokenId,);
                return token?.type == TokenType.erc20 || token?.type == TokenType.native;
              },
            )
            .toList();
      case AppNetworkType.other:
        return [];
    }
  }
}
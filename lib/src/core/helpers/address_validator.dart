import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:wallet_core/wallet_core.dart';

bool addressInValid({
  required String address,
  int coinType = TWCoinType.TWCoinTypeEthereum,
}) {
  try {
    if (coinType == TWCoinType.TWCoinTypeCosmos) {
      final data =
          bech32.makeBech32Decoder(AppLocalConstant.auraPrefix, address);

      return AnyAddress.isValid(
        bech32.makeBech32Encoder('cosmos', data),
        coinType,
      );
    }

    return AnyAddress.isValid(address, coinType);
  } catch (e) {
    return false;
  }
}

import 'package:wallet_core/wallet_core.dart';

bool addressInValid({
  required String address,
  int coinType = TWCoinType.TWCoinTypeEthereum,
}) {
  try {
    return AnyAddress.isValid(address, coinType);
  } catch (e) {
    return false;
  }
}

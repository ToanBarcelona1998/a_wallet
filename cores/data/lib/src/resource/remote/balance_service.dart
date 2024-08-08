import 'package:data/core/base_response.dart';

abstract interface class BalanceService {
  Future<String> getNativeBalance({
    required String address,
  });

  Future<XWalletBaseResponseV2> getErc20Balance({
    required Map<String,dynamic> body,
  });
}
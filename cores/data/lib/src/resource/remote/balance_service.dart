import 'package:data/core/base_response.dart';

abstract interface class BalanceService {
  Future<String> getNativeBalance({
    required String address,
  });

  Future<AuraBaseResponseV2> getErc20Balance({
    required Map<String,dynamic> body,
  });

  Future<AuraBaseResponseV2> getCw20Balance({
    required Map<String,dynamic> body,
  });
}
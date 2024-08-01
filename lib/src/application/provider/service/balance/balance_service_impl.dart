import 'package:data/core/base_response.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:a_wallet/src/application/provider/service/api_service_path.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wallet_core/wallet_core.dart';

part 'balance_service_impl.g.dart';

final class BalanceServiceImpl implements BalanceService {

  final BalanceServiceGenerator _balanceServiceGenerator;

  const BalanceServiceImpl(this._balanceServiceGenerator);

  @override
  Future<AuraBaseResponseV2> getCw20Balance(
      {required Map<String, dynamic> body}) {
    return _balanceServiceGenerator.getCw20Balance(body);
  }

  @override
  Future<AuraBaseResponseV2> getErc20Balance(
      {required Map<String, dynamic> body}) {
    return _balanceServiceGenerator.getErc20Balance(body);
  }

  @override
  Future<String> getNativeBalance({required String address}) async {
    final amount = await ChainList.auraEuphoria.getWalletBalance(address);
    return amount.toString();
  }
}

@RestApi()
abstract class BalanceServiceGenerator {
  factory BalanceServiceGenerator(
    Dio dio, {
    String? baseUrl,
  }) = _BalanceServiceGenerator;

  @POST(ApiServicePath.graphiql)
  Future<AuraBaseResponseV2> getCw20Balance(@Body() Map<String, dynamic> body,);

  @POST(ApiServicePath.graphiql)
  Future<AuraBaseResponseV2> getErc20Balance(@Body() Map<String, dynamic> body,);
}

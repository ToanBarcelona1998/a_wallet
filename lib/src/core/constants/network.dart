import 'package:domain/domain.dart';
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';

AppNetwork createNetwork(PyxisMobileConfig config){
  return AppNetwork(
    id: 1,
    type: AppNetworkType.evm,
    rpc: config.config.evmInfo.rpc,
    symbol: config.config.evmInfo.symbol,
    denom: config.config.evmInfo.denom,
    isActive: true,
    name: config.config.evmInfo.chainName,
  );
}
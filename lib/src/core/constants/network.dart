import 'package:domain/domain.dart';
import 'package:a_wallet/app_configs/a_wallet_config.dart';

AppNetwork createNetwork(AWalletConfig config){
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
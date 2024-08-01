import 'package:wallet_core/src/objects/chain_info.dart';

class ChainList {
  static ChainInfo auraSerenity = EvmChainInfo(
    rpcUrl: 'https://jsonrpc.serenity.aura.network',
    chainId: '1236',
    symbol: 'AURA',
    name: 'Aura Serenity',
    icon:
        'https://raw.githubusercontent.com/aurora-is-near/aurora-web/main/public/favicon.ico',
  );

  static ChainInfo auraEuphoria = EvmChainInfo(
    rpcUrl: 'https://jsonrpc.euphoria.aura.network',
    chainId: '6321',
    symbol: 'AURA',
    name: 'Aura Euphoria',
    icon:
        'https://raw.githubusercontent.com/aurora-is-near/aurora-web/main/public/favicon.ico',
  );

  static ChainInfo auraEVM = EvmChainInfo(
    rpcUrl: 'https://jsonrpc.aura.network',
    chainId: '6322',
    symbol: 'AURA',
    name: 'Aura EVM',
    icon:
        'https://raw.githubusercontent.com/aurora-is-near/aurora-web/main/public/favicon.ico',
  );

  static ChainInfo ethereum = EvmChainInfo(
    rpcUrl: 'https://eth.llamarpc.com',
    chainId: '1',
    symbol: 'ETH',
    name: 'Ethereum',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png',
  );

  static ChainInfo bsc = EvmChainInfo(
    rpcUrl: 'https://bsc-dataseed.binance.org/',
    chainId: '56',
    symbol: 'BNB',
    name: 'Binance Smart Chain',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/smartchain/info/logo.png',
  );

  static ChainInfo tron = EvmChainInfo(
    rpcUrl: 'https://api.trongrid.io',
    chainId: '1',
    symbol: 'TRX',
    name: 'Tron',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/tron/info/logo.png',
  );

  static ChainInfo solana = EvmChainInfo(
    rpcUrl: 'https://api.mainnet-beta.solana.com',
    chainId: '101',
    symbol: 'SOL',
    name: 'Solana',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/solana/info/logo.png',
  );

  static ChainInfo polygon = EvmChainInfo(
    rpcUrl: 'https://rpc-mainnet.maticvigil.com',
    chainId: '137',
    symbol: 'MATIC',
    name: 'Polygon',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/polygon/info/logo.png',
  );

  static ChainInfo avalanche = EvmChainInfo(
    rpcUrl: 'https://api.avax.network/ext/bc/C/rpc',
    chainId: '43114',
    symbol: 'AVAX',
    name: 'Avalanche',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/avalanche/info/logo.png',
  );

  static ChainInfo fantom = EvmChainInfo(
    rpcUrl: 'https://rpcapi.fantom.network',
    chainId: '250',
    symbol: 'FTM',
    name: 'Fantom',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/fantom/info/logo.png',
  );

  static ChainInfo celo = EvmChainInfo(
    rpcUrl: 'https://forno.celo.org',
    chainId: '42220',
    symbol: 'CELO',
    name: 'Celo',
    icon:
        'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/celo/info/logo.png',
  );
}

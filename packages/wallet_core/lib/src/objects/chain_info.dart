import 'dart:typed_data';

import 'package:http/http.dart'; //You can also import the browser version
import 'package:wallet_core/wallet_core.dart';
import 'package:web3dart/web3dart.dart';

abstract class ChainInfo {
  final String rpcUrl;
  final String chainId;
  final String symbol;
  final String name;
  final String icon;

  ChainInfo(
      {required this.rpcUrl,
      required this.chainId,
      required this.symbol,
      required this.name,
      required this.icon});

  Future<BigInt> getWalletBalance(String address);
}

class EvmChainInfo extends ChainInfo {
  late final Web3Client _web3client;

  EvmChainInfo(
      {required super.rpcUrl,
      required super.chainId,
      required super.symbol,
      required super.name,
      required super.icon}) {
    _web3client = Web3Client(rpcUrl, Client());
  }

  @override
  Future<BigInt> getWalletBalance(String address) async {
    final ethAddress = EthereumAddress.fromHex(address);
    final balance = await _web3client.getBalance(ethAddress);
    return balance.getInWei;
  }
}

class CosmonsChainInfo extends ChainInfo {
  CosmonsChainInfo(
      {required super.rpcUrl,
      required super.chainId,
      required super.symbol,
      required super.name,
      required super.icon});

  @override
  Future<BigInt> getWalletBalance(String address) async {
    throw UnimplementedError();
  }
}

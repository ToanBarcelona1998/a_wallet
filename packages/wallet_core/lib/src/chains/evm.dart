import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:web3dart/web3dart.dart';
import 'package:trust_wallet_core/protobuf/Ethereum.pb.dart' as Ethereum;

class EvmChainClient {
  final ChainInfo chainInfo;
  final Web3Client _web3client;

  EvmChainClient(this.chainInfo)
      : _web3client = Web3Client(chainInfo.rpcUrl, Client());

  Future<BigInt> getWalletBalance(String address) async {
    final ethAddress = EthereumAddress.fromHex(address);
    final balance = await _web3client.getBalance(ethAddress);
    return balance.getInWei;
  }

  Future<String> sendTransaction({
    required Uint8List rawTransaction,
  }) async {
    final String hash = await _web3client.sendRawTransaction(
      Uint8List.fromList(rawTransaction),
    );

    return hash;
  }

  Future<TransactionReceipt> verifyTransaction({
    required String hash,
    int times = 0,
  }) async {
    try {
      await Future.delayed(
        const Duration(
          milliseconds: 2100,
        ),
      );
      final TransactionReceipt? tx =
          await _web3client.getTransactionReceipt(hash);

      if (tx == null) {
        throw Exception('Transaction execute failed');
      }

      print(tx.toString());

      return tx;
    } catch (e) {
      if (times == 5) {
        rethrow;
      }
      return verifyTransaction(
        hash: hash,
        times: times + 1,
      );
    }
  }

  Future<Ethereum.SigningOutput> createTransferTransaction({
    required AWallet wallet,
    required BigInt amount,
    required BigInt gasLimit,
    required String recipient,
    BigInt? gasPrice,
  }) async {
    final BigInt chainId = await _web3client.getChainId();

    if (gasPrice == null) {
      final EtherAmount remoteGasPrice = await _web3client.getGasPrice();

      gasPrice = remoteGasPrice.getInWei;
    }

    final nonce = await _web3client.getTransactionCount(
      EthereumAddress.fromHex(
        wallet.address,
      ),
    );

    return createEvmTransferTransaction(
      privateKey: wallet.privateKeyData,
      chainId: chainId,
      amount: amount,
      gasLimit: gasLimit,
      recipient: recipient,
      gasPrice: gasPrice,
      nonce: BigInt.from(nonce),
    );
  }

  Future<Ethereum.SigningOutput> createErc20Transaction({
    required AWallet wallet,
    required BigInt amount,
    required BigInt gasLimit,
    required String contractAddress,
    required String recipient,
    BigInt? gasPrice,
  }) async {
    final BigInt chainId = await _web3client.getChainId();

    if (gasPrice == null) {
      final EtherAmount remoteGasPrice = await _web3client.getGasPrice();

      gasPrice = remoteGasPrice.getInWei;
    }

    final nonce = await _web3client.getTransactionCount(
      EthereumAddress.fromHex(
        wallet.address,
      ),
    );

    return createErc20TransferTransaction(
      privateKey: wallet.privateKeyData,
      chainId: chainId,
      amount: amount,
      gasLimit: gasLimit,
      contractAddress: contractAddress,
      recipient: recipient,
      gasPrice: gasPrice,
      nonce: BigInt.from(nonce),
    );
  }

  Future<BigInt> estimateGas({
    required String sender,
    required BigInt amount,
    required String recipient,
    Uint8List? data,
  }) async {
    return _web3client.estimateGas(
      to: EthereumAddress.fromHex(recipient),
      sender: EthereumAddress.fromHex(
        sender,
      ),
      value: EtherAmount.fromBigInt(
        EtherUnit.wei,
        amount,
      ),
      data: data,
    );
  }

  Future<BigInt> getGasPrice() async {
    final gasPrice = await _web3client.getGasPrice();

    return gasPrice.getInWei;
  }
}

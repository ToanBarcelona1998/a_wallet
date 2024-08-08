import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet_core/src/objects/chain_info.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:trust_wallet_core/protobuf/Ethereum.pb.dart' as Ethereum;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:flutter/material.dart';
import 'package:trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:trust_wallet_core/protobuf/Tron.pb.dart' as Tron;
import 'package:trust_wallet_core/trust_wallet_core_ffi.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

/// Class to hold wallet information.
class AWallet {
  final HDWallet? wallet;
  final String address;
  final PrivateKey _privateKey;
  final int coinType;
  final Logger logger = Logger();

  AWallet(
      {this.wallet,
      required this.address,
      required PrivateKey privateKey,
      required this.coinType})
      : _privateKey = privateKey;

  String get privateKey {
    return hex.encode(_privateKey.data());
  }

  Uint8List get privateKeyData {
    return _privateKey.data();
  }

  // Future<String> signMessage(String message) async {
  //   try {
  //     // Prefix the message with the Ethereum signing prefix
  //     final prefix = '\u0019Ethereum Signed Message:\n${message.length}';
  //     final prefixedMessage = utf8.encode(prefix + message);

  //     // Hash the message
  //     final messageHash = keccak256(Uint8List.fromList(prefixedMessage));

  //     // Create the Ethereum SigningInput protobuf message
  //     final signingInput = Ethereum.SigningInput(
  //       privateKey: _privateKey.data().toList(),
  //       messageHash: messageHash.toList(),
  //     );

  //     // Use AnySigner to sign the message
  //     final output = Ethereum.SigningOutput.fromBuffer(
  //       AnySigner.sign(signingInput.writeToBuffer(), coinType).toList(),
  //     );

  //     // Return the signed message
  //     return hex.encode(output.encoded.toList());
  //   } catch (e) {
  //     logger.d('Error signing message: $e');
  //     return '';
  //   }
  // }

  Future<void> sendTransaction(String toAddress, BigInt amount, BigInt gasPrice,
      BigInt gasLimit) async {}

  Uint8List? addressList() {
    print('getAddressForCoin = ${wallet!.getAddressForCoin(coinType)}');
    print('address = $address');
    final addressList =
        Base58.base58DecodeNoCheck(wallet!.getAddressForCoin(coinType));
    if (addressList == null) {
      print("addressList null !!!");
      return null;
    }
    print("addressList = $addressList");
    String hexaaddress = hex.encode(addressList);

    print("hexAddress = $hexaaddress");
    return addressList;
  }

  void tronExample() {
    final now = DateTime.now();

    int coin = TWCoinType.TWCoinTypeTron;

    //nowBlock 可通过 https://cn.developers.tron.network/reference#%E8%8E%B7%E5%BE%97%E6%9C%80%E6%96%B0%E7%9A%84%E9%98%BB%E6%AD%A2  获取最新区块
    String nowBlock =
        '{"blockID":"00000000011918071ecc35c6178f7cea6abf0a0747cf1084b43c9660bd02eb24","block_header":{"raw_data":{"number":18421767,"txTrieRoot":"0000000000000000000000000000000000000000000000000000000000000000","witness_address":"41839d08f05ade5b365e81d1a66c20af13ebb2991d","parentHash":"0000000001191806eeaac4f94195754bab81a6da304f839f15f12ba874e57884","version":22,"timestamp":1631928606000},"witness_signature":"8c0f92f8880521a21c2d9ecf7b1b58cffbaa6ce739c465cb1118328dcd901b0f699d669d3b3382150c4823cab64d644517d92f378dbbbcd2ae1bb535ac08799500"}}';
    Map blockHeader = json.decode(nowBlock)['block_header']['raw_data'];
    print(blockHeader);
    logger.d(wallet!.getAddressForCoin(coin));
    final addressList =
        Base58.base58DecodeNoCheck(wallet!.getAddressForCoin(coin));
    if (addressList == null) {
      print("addressList null !!!");
      return;
    }
    String hexaaddress = hex.encode(addressList);
    logger.d("hexAddress = $hexaaddress");

    final input = Tron.SigningInput(
        transaction: Tron.Transaction(
          transfer: Tron.TransferContract(
            ownerAddress: wallet!.getAddressForCoin(coin),
            toAddress: 'TD3QZkapTC2Uuq1Tn6tv4TfzagDHxr7gxz',
            amount: $fixnum.Int64.parseInt('200000'),
          ),
          timestamp:
              $fixnum.Int64.parseInt(now.millisecondsSinceEpoch.toString()),
          expiration: $fixnum.Int64.parseInt(
              '${now.millisecondsSinceEpoch + 10 * 60 * 60 * 1000}'),
          blockHeader: Tron.BlockHeader(
            timestamp:
                $fixnum.Int64.parseInt(blockHeader['timestamp'].toString()),
            txTrieRoot: hex.decode(blockHeader['txTrieRoot']),
            parentHash: hex.decode(blockHeader['parentHash']),
            number: $fixnum.Int64.parseInt(blockHeader['number'].toString()),
            witnessAddress: hex.decode(blockHeader['witness_address']),
            version: blockHeader['version'],
          ),
        ),
        privateKey: wallet!.getKeyForCoin(coin).data().toList());
    final output = Tron.SigningOutput.fromBuffer(
        AnySigner.sign(input.writeToBuffer(), coin).toList());
    logger.d(output.json);
    print(output.json);

    Tron.Transaction tr = Tron.Transaction(
        freezeBalance: Tron.FreezeBalanceContract(
          ownerAddress: "TUQuaXCjDhLQsJbUeCN42PTZzQQnGh7SQP",
          frozenBalance: $fixnum.Int64.parseInt("4900000"),
          frozenDuration: $fixnum.Int64.parseInt("3"),
          resource: "ENERGY",
        ),
        blockHeader: Tron.BlockHeader(
          timestamp:
              $fixnum.Int64.parseInt(blockHeader['timestamp'].toString()),
          txTrieRoot: hex.decode(blockHeader['txTrieRoot']),
          parentHash: hex.decode(blockHeader['parentHash']),
          number: $fixnum.Int64.parseInt(blockHeader['number'].toString()),
          witnessAddress: hex.decode(blockHeader['witness_address']),
          version: blockHeader['version'],
        ));
    final freeze = Tron.SigningInput(
      transaction: tr,
      privateKey: wallet!.getKeyForCoin(coin).data().toList(),
    );
    final freezeOutput = Tron.SigningOutput.fromBuffer(
        AnySigner.sign(freeze.writeToBuffer(), coin).toList());
    print(freezeOutput.json);
  }

  void ethereumExample() {
    int coin = TWCoinType.TWCoinTypeEthereum;

    final toAddress = '0xAddressToSendTo';
    final amount = BigInt.parse('1000000000000000000'); // 1 ETH in Wei
    final gasPrice = BigInt.parse('20000000000'); // 20 GWei
    final gasLimit = BigInt.parse('21000');
    final nonce = BigInt.parse('0'); // Replace with actual nonce

    final signingInput = Ethereum.SigningInput(
      chainId: _bigIntToBytes(BigInt.from(1)), // Mainnet
      nonce: _bigIntToBytes(nonce),
      gasPrice: _bigIntToBytes(gasPrice),
      gasLimit: _bigIntToBytes(gasLimit),
      toAddress: toAddress,
      privateKey: wallet!.getKeyForCoin(coin).data().toList(),
      transaction: Ethereum.Transaction(
        transfer: Ethereum.Transaction_Transfer(
          amount: _bigIntToBytes(amount),
        ),
      ),
    );

    final output = Ethereum.SigningOutput.fromBuffer(
      AnySigner.sign(signingInput.writeToBuffer(), coin).toList(),
    );

    logger.d('Transaction JSON: ${output.encoded}');
  }

  List<int> _bigIntToBytes(BigInt number) {
    final byteData = ByteData(32);
    final bigIntBytes =
        number.toUnsigned(256).toRadixString(16).padLeft(64, '0');
    final bytes = hex.decode(bigIntBytes);
    byteData.buffer.asUint8List().setRange(32 - bytes.length, 32, bytes);
    return byteData.buffer.asUint8List();
  }
}

class Logger {
  void d(String message) {
    print(message);
  }
}

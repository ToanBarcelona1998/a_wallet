import 'dart:typed_data';

import 'package:bech32/bech32.dart';
import 'package:convert/convert.dart';
import 'package:trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:trust_wallet_core/trust_wallet_core_ffi.dart';
import 'package:wallet_core/src/constants/constants.dart';
import 'package:wallet_core/wallet_core.dart';

String mnemonic = 'hen cat bread cry obey wrist click tunnel certain decade resemble muscle';

String privateKey = '0e63dd62f94699348a88dde6c075dd970b83d4091a03ad7c5b51adc95129c229';

String privateKey2 = '6bfc6e4afd58ce8cd1583f290f86ad2d0cbc7b9ab26201659337923856fdbb1c';

const type1 = TWCoinType.TWCoinTypeCosmos;

void test1(){
  final wallet = HDWallet.createWithMnemonic(mnemonic);

  final privateKey = wallet.getKeyForCoin(type1);

  print('private key 1 = ${hex.encode(privateKey.data())}');

  print('address 1 ${wallet.getAddressForCoin(type1)}');
}

void test2(){
  final wallet = HDWallet.createWithMnemonic(mnemonic);

  final privateKey = wallet.getKey(type1,Constants.derivationPathCosmos);

  print('private key 2 = ${hex.encode(privateKey.data())}');

  print('address 2 ${wallet.getAddressForCoin(type1)}');
}

void test3(){
  PrivateKey privateKeyCreate = PrivateKey.createWithData(Uint8List.fromList(hex.decode(privateKey)));

  final publicKey = privateKeyCreate.getPublicKeySecp256k1(true);

  final anyAddress = AnyAddress.createWithPublicKey(publicKey, type1);

  print('test 3 ${anyAddress.description()}');

  final data = bech32.makeBech32Decoder('cosmos', anyAddress.description());

  print('test 3 ${bech32.convertBech32AddressToEthAddress('cosmos', anyAddress.description())}');

  print('test 3 ${bech32.makeBech32Encoder('aura', data)}');



  print('add ${bech32.makeBech32Encoder('aura', anyAddress.data())}');


  print('address ${bech32.convertBech32AddressToEthAddress('aura',bech32.makeBech32Encoder('aura', anyAddress.data()))}');
}

void test4(){
  PrivateKey privateKeyCreate = PrivateKey.createWithData(Uint8List.fromList(hex.decode(privateKey2)));

  final publicKey = privateKeyCreate.getPublicKeySecp256k1(false);

  final anyAddress = AnyAddress.createWithPublicKey(publicKey, TWCoinType.TWCoinTypeEthereum);

  print('test 4 ${bech32.makeBech32Encoder('aura', anyAddress.data())}');

  print('test 4 ${anyAddress.description()}');

}

void test5(){
  final wallet = HDWallet.createWithMnemonic(mnemonic);

  final privateKey = wallet.getKeyForCoin(TWCoinType.TWCoinTypeEthereum);

  print('test 5 = ${hex.encode(privateKey.data())}');

  print('test 5 ${wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum)}');
}
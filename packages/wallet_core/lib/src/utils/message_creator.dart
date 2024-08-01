import 'dart:typed_data';

import 'package:trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:trust_wallet_core/protobuf/Ethereum.pb.dart' as Ethereum;
import 'package:trust_wallet_core/trust_wallet_core_ffi.dart';
import 'package:wallet_core/src/extensions/bigint_extension.dart';

Ethereum.SigningOutput evmSigner(Uint8List bytes){
  final Uint8List signBytes = AnySigner.sign(
    bytes,
    TWCoinType.TWCoinTypeEthereum,
  );

  return Ethereum.SigningOutput.fromBuffer(signBytes);
}

Ethereum.SigningOutput createErc20TransferTransaction({
  required Uint8List privateKey,
  required BigInt chainId,
  required BigInt amount,
  required BigInt gasLimit,
  required String contractAddress,
  required String recipient,
  required BigInt gasPrice,
  required BigInt nonce,
}) {
  final Ethereum.SigningInput signingInput = Ethereum.SigningInput(
    toAddress: contractAddress,
    privateKey: privateKey,
    chainId: chainId.toUin8List(),
    gasPrice: gasPrice.toUin8List(),
    gasLimit: gasLimit.toUin8List(),
    nonce: nonce.toUin8List(),
    transaction: Ethereum.Transaction(
      erc20Transfer: Ethereum.Transaction_ERC20Transfer(
        amount: amount.toUin8List(),
        to: recipient,
      ),
    ),
  );

  return evmSigner(signingInput.writeToBuffer());
}

Ethereum.SigningOutput createEvmTransferTransaction({
  required Uint8List privateKey,
  required BigInt chainId,
  required BigInt amount,
  required BigInt gasLimit,
  required String recipient,
  required BigInt gasPrice,
  required BigInt nonce,
}) {
  final Ethereum.SigningInput signingInput = Ethereum.SigningInput(
    toAddress: recipient,
    privateKey: privateKey,
    chainId: chainId.toUin8List(),
    gasPrice: gasPrice.toUin8List(),
    gasLimit: gasLimit.toUin8List(),
    nonce: nonce.toUin8List(),
    transaction: Ethereum.Transaction(
      transfer: Ethereum.Transaction_Transfer(
        amount: amount.toUin8List(),
      ),
    ),
  );

  return evmSigner(signingInput.writeToBuffer());
}

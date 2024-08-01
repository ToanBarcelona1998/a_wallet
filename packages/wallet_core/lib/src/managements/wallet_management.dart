import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:wallet_core/src/constants/constants.dart';
import 'package:wallet_core/wallet_core.dart';

class WalletManagement {
  /// Generates a random mnemonic phrase.
  ///
  /// [strength] determines the strength of the mnemonic phrase.
  /// [passphrase] is an optional passphrase to use with the mnemonic.
  /// Returns the generated mnemonic phrase.
  String randomMnemonic({int strength = 128, String passphrase = ''}) {
    return HDWallet(strength: strength, passphrase: passphrase).mnemonic();
  }

  /// Generates a random HDWallet.
  ///
  /// [strength] determines the strength of the mnemonic phrase.
  /// [passphrase] is an optional passphrase to use with the mnemonic.
  /// Returns the generated HDWallet.
  HDWallet randomWallet({int strength = 128, String passphrase = ''}) {
    return HDWallet(strength: strength, passphrase: passphrase);
  }

  /// Imports a wallet using a mnemonic phrase.
  ///
  /// [mnemonic] is the mnemonic phrase of the wallet.
  /// Returns the AWallet containing the HDWallet and address.
  AWallet importWallet(
    String mnemonic, {
    int coinType = Constants.defaultCoinType,
  }) {
    final wallet = HDWallet.createWithMnemonic(mnemonic);
    final address = wallet.getAddressForCoin(coinType);

    return AWallet(
      wallet: wallet,
      address: address,
      privateKey: wallet.getKeyForCoin(
        coinType,
      ),
      coinType: coinType,
    );
  }

  /// Imports a wallet using a private key.
  ///
  /// [privateKey] is the private key in hex format.
  /// [coinType] specifies the type of the coin.
  /// Returns the AWallet containing the address and private key.
  AWallet importWalletWithPrivateKey(
    String privateKey, {
    int coinType = Constants.defaultCoinType,
  }) {
    try {
      final bytes = hex.decode(privateKey); // Decode the hex string to bytes
      final pk = PrivateKey.createWithData(
          Uint8List.fromList(bytes)); // Create a PrivateKey object

      PublicKey publicKey;

      switch (coinType) {
        case Constants.defaultCoinType:
          publicKey = pk.getPublicKeySecp256k1(false); // Get the public key
        case Constants.cosmosCoinType:
          publicKey = pk.getPublicKeySecp256k1(true);
        default:
          publicKey = pk.getPublicKeySecp256k1(false); // Get the public key
          break;
      }

      final anyAddress = AnyAddress.createWithPublicKey(
          publicKey, coinType); // Create an AnyAddress object
      final address = anyAddress.description(); // Get the address description

      return AWallet(
          wallet: null, address: address, privateKey: pk, coinType: coinType);
    } catch (e) {
      // Handle potential errors
      throw Exception('Invalid private key or unsupported coin type');
    }
  }

  /// Retrieves the private key for a specific coin type.
  ///
  /// [wallet] is the HDWallet object.
  /// [coinType] specifies the type of the coin.
  /// Returns the private key in hex format.
  String getPrivateKey(HDWallet wallet,
      {int coinType = Constants.defaultCoinType}) {
    return hex.encode(wallet
        .getKeyForCoin(coinType)
        .data()); // Encode the private key to hex format
  }
}

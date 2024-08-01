import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:wallet_core/src/constants/constants.dart';
import 'package:wallet_core/src/objects/wallet_exception.dart';
import 'package:wallet_core/wallet_core.dart';

class StoredManagement {
  /// Saves a wallet, either mnemonic or private key based.
  ///
  /// [name] is the name of the wallet.
  /// [password] is the password for the wallet.
  /// [aWallet] is the wallet to be saved.
  /// [coinType] specifies the type of the coin.
  /// Returns the JSON representation of the stored key or throws an exception.
  String? saveWallet(String name, String password, AWallet aWallet,
      {int coinType = Constants.defaultCoinType}) {
    try {
      StoredKey? storedKey = aWallet.wallet != null
          ? StoredKey.importHDWallet(
              aWallet.wallet!.mnemonic(), name, password, coinType)
          : StoredKey.importPrivateKey(
              Uint8List.fromList(hex.decode(aWallet.privateKey)),
              name,
              password,
              coinType);

      if (storedKey == null) {
        throw WalletException('Failed to save wallet');
      }

      return storedKey.exportJson();
    } catch (e) {
      throw WalletException('Failed to save wallet: $e');
    }
  }

  /// Imports a stored key from JSON.
  ///
  /// [storedKey] is the JSON representation of the stored key.
  /// [password] is the password for the stored key.
  /// Returns the imported AWallet or null if import fails.
  AWallet? fromSavedJson(String storedKey, String password,
      {int coinType = Constants.defaultCoinType}) {
    try {
      StoredKey? storedWallet = StoredKey.importJson(storedKey);
      if (storedWallet == null) {
        return null;
      }

      if (storedWallet.isMnemonic()) {
        HDWallet? hdWallet = storedWallet.wallet(password);
        if (hdWallet == null) {
          return null;
        }
        return WalletCore.walletManagement.importWallet(
          hdWallet.mnemonic(),
          coinType: coinType,
        );
      }

      PrivateKey? privateKey = storedWallet.privateKey(
          coinType, Uint8List.fromList(password.codeUnits));
      if (privateKey == null) {
        return null;
      }

      String privateKeyHex = hex.encode(privateKey.data());
      return WalletCore.walletManagement
          .importWalletWithPrivateKey(privateKeyHex);
    } catch (e) {
      throw WalletException('Failed to import wallet from JSON: $e');
    }
  }
}

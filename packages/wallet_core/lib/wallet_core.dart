library wallet_core;

import 'package:trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:wallet_core/src/managements/stored_key_management.dart';
import 'package:wallet_core/src/managements/wallet_management.dart';

// Exporting necessary packages for external usage
export 'package:trust_wallet_core/trust_wallet_core_ffi.dart';
export 'package:trust_wallet_core/flutter_trust_wallet_core.dart';
export 'package:trust_wallet_core/trust_wallet_core.dart';
export 'package:wallet_core/src/managements/stored_key_management.dart';
export 'package:wallet_core/src/managements/wallet_management.dart';
export 'package:wallet_core/src/objects/a_wallet.dart';
export 'package:wallet_core/src/objects/chain_info.dart';
export 'package:wallet_core/src/constants/chain_list.dart';
export 'package:wallet_core/src/chains/evm.dart';
export 'package:wallet_core/src/utils/address_converter.dart';
export 'package:wallet_core/src/utils/message_creator.dart';
export 'package:wallet_core/src/utils/wallet_utils.dart';
export 'package:web3dart/crypto.dart';

/// WalletCore class provides various functionalities to manage wallets.
class WalletCore {
  static void init() {
    FlutterTrustWalletCore.init();
  }

  static WalletManagement walletManagement = WalletManagement();
  static StoredManagement storedManagement = StoredManagement();
}

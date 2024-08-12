import 'package:a_wallet/src/core/constants/asset_path.dart';

sealed class AppLocalConstant {
  // account db name
  static const String localDbName = 'px_wallet_database_v2.isar';

  // Secure storage prefix
  static const String secureStorageName = 'px_wallet_secure_storage';
  static const String secureStoragePrefix = 'px_wallet_secure_storage_prefix';

  // Passcode and biometric key
  static const String passCodeKey = 'px_app_pass_code';
  static const String bioMetricKey = 'px_app_bio_metric';


  static const String auraPrefix = 'aura';
  static const String auraLogo = 'https://aurascan.io/assets/images/logo/title-logo.png';

  static const String googleSearchUrl = 'https://www.google.com/search';
  static const String googleSearchName = 'Google search';

  static const String defaultNormalWalletName = 'Wallet 1';

  static const List<String> avatars = [
    AssetImagePath.defaultAvatar1,
    AssetImagePath.defaultAvatar2,
    AssetImagePath.defaultAvatar3,
  ];
}

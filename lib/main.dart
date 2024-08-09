import 'dart:convert';

import 'package:a_wallet/src/application/provider/local/address_book/address_book_db.dart';
import 'package:a_wallet/src/application/provider/local/book_mark/bookmark_db.dart';
import 'package:a_wallet/src/application/provider/local/browser/browser_db.dart';
import 'package:a_wallet/src/core/constants/aura_ecosystem.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:a_wallet/app_configs/di.dart' as di;
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/application/provider/local/account/account_db.dart';
import 'package:a_wallet/src/application/provider/local/balance/balance_db.dart';
import 'package:a_wallet/src/application/provider/local/key_store/key_store_db.dart';
import 'package:a_wallet/src/application/provider/local/token/token_db.dart';
import 'package:a_wallet/src/application/provider/local/token_market/token_market_db.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/aura_scan.dart';
import 'package:a_wallet/src/a_wallet_application.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;

// Change this one if you want to change environment
const AWalletEnvironment environment = AWalletEnvironment.staging;

class LogProviderImpl implements LogProvider {
  @override
  void printLog(String message) {
    developer.log(message, name: 'a_wallet');
  }
}

Future<Map<String, dynamic>> _loadConfig() async {
  String loader;
  String path;

  switch (environment) {
    case AWalletEnvironment.serenity:
      path = AssetConfigPath.configDev;
      break;
    case AWalletEnvironment.staging:
      path = AssetConfigPath.configStaging;
      break;
    case AWalletEnvironment.production:
      path = AssetConfigPath.config;
      break;
  }
  try {
    loader = await rootBundle.loadString(
      path,
    );
  } catch (e) {
    loader = '';
    LogProvider.log('can\'t load config ${e.toString()}');
  }

  return jsonDecode(loader);
}

Future<void> _saveAuraToken(String name, String symbol) async {
  final TokenUseCase tokenUseCase = di.getIt.get<TokenUseCase>();
  final nativeAura = await tokenUseCase.getByName(
    name: name,
  );

  if (nativeAura == null) {
    await tokenUseCase.add(
      AddTokenRequest(
        logo: AppLocalConstant.auraLogo,
        tokenName: name,
        type: TokenType.native,
        symbol: symbol,
        contractAddress: '',
        isEnable: true,
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LogProvider.init(
    LogProviderImpl(),
  );

  AuraScan.init(environment);

  AuraEcosystem.init(environment);

  final Map<String, dynamic> config = await _loadConfig();

  // Get the path to the application documents directory
  final path = (await getApplicationDocumentsDirectory()).path;

  late Isar isar;
  if (Isar.instanceNames.isEmpty) {
    // Open the Isar database with the specified schema, directory, name, and maximum size
    isar = await Isar.open(
      [
        AccountDbSchema,
        KeyStoreDbSchema,
        AccountBalanceDbSchema,
        TokenMarketDbSchema,
        TokenDbSchema,
        BrowserDbSchema,
        BookMarkDbSchema,
        AddressBookDbSchema,
      ],
      directory: path,
      name: AppLocalConstant.localDbName,
      maxSizeMiB: 128,
    );
  } else {
    // Get the existing instance of the Isar database
    isar = Isar.getInstance(AppLocalConstant.localDbName)!;
  }

  final aWalletConfig = AWalletConfig(
    configs: config,
    environment: environment,
  );

  // Init dependencies
  await di.initDependency(
    aWalletConfig,
    isar,
  );

  await _saveAuraToken(
    aWalletConfig.config.nativeCoin.name,
    aWalletConfig.config.nativeCoin.symbol,
  );

  // Load language
  await AppLocalizationManager.instance.load();

  FlutterTrustWalletCore.init();

  runApp(
    const AWalletApplication(),
  );
}
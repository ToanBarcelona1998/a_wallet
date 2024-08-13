import 'dart:io';
import 'package:a_wallet/src/application/provider/local/address_book/address_book_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/book_mark/book_mark_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/browser/browser_database_service_impl.dart';
import 'package:a_wallet/src/core/observer/wallet_page_observer.dart';
import 'package:a_wallet/src/presentation/screens/address_book/address_book_bloc.dart';
import 'package:a_wallet/src/presentation/screens/browser/browser_bloc.dart';
import 'package:a_wallet/src/presentation/screens/browser_search/browser_search_bloc.dart';
import 'package:a_wallet/src/presentation/screens/browser_tab_management/browser_tab_management_bloc.dart';
import 'package:a_wallet/src/presentation/screens/confirm_transfer_nft/confirm_send_bloc.dart';
import 'package:a_wallet/src/presentation/screens/home/browser/browser_page_bloc.dart';
import 'package:a_wallet/src/presentation/screens/home/setting/setting_cubit.dart';
import 'package:a_wallet/src/presentation/screens/home/wallet/wallet_cubit.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_bloc.dart';
import 'package:a_wallet/src/presentation/screens/nft_transfer/nft_transfer_bloc.dart';
import 'package:a_wallet/src/presentation/screens/setting_change_passcode/setting_change_passcode_cubit.dart';
import 'package:a_wallet/src/presentation/screens/setting_passcode_and_biometric/setting_passcode_and_biometric_cubit.dart';
import 'package:a_wallet/src/presentation/screens/signed_import_wallet/signed_import_wallet_bloc.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:a_wallet/src/application/provider/local/account/account_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/balance/balance_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/key_store/key_store_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/localization_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/normal_storage_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/secure_storage_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/token/token_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/local/token_market/token_market_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/provider/biometric_provider.dart';
import 'package:a_wallet/src/application/provider/provider/web3_auth_provider.dart';
import 'package:a_wallet/src/application/provider/service/balance/balance_service_impl.dart';
import 'package:a_wallet/src/application/provider/service/nft/nft_service_impl.dart';
import 'package:a_wallet/src/application/provider/service/token_market/remote_token_market_service_impl.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/network.dart';
import 'package:a_wallet/src/core/observer/home_page_observer.dart';
import 'package:a_wallet/src/presentation/screens/confirm_send/confirm_send_bloc.dart';
import 'package:a_wallet/src/presentation/screens/create_passcode/create_passcode_cubit.dart';
import 'package:a_wallet/src/presentation/screens/generate_wallet/generate_wallet_cubit.dart';
import 'package:a_wallet/src/presentation/screens/get_started/get_started_cubit.dart';
import 'package:a_wallet/src/presentation/screens/home/home/home_page_bloc.dart';
import 'package:a_wallet/src/presentation/screens/home/home_bloc.dart';
import 'package:a_wallet/src/presentation/screens/import_wallet/import_wallet_bloc.dart';
import 'package:a_wallet/src/presentation/screens/import_wallet_yeti_bot/import_wallet_yeti_bot_cubit.dart';
import 'package:a_wallet/src/presentation/screens/manage_token/manage_token_bloc.dart';
import 'package:a_wallet/src/presentation/screens/re_login/re_login_cubit.dart';
import 'package:a_wallet/src/presentation/screens/send/send_bloc.dart';
import 'package:a_wallet/src/presentation/screens/social_login_yeti_bot/social_login_yeti_bot_cubit.dart';
import 'package:a_wallet/src/presentation/screens/splash/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

import 'a_wallet_config.dart';

final getIt = GetIt.instance;

Future<void> initDependency(
  AWalletConfig config,
  Isar isar,
) async {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: config.config.api.v2.url,
      connectTimeout: const Duration(
        milliseconds: 60000,
      ),
      receiveTimeout: const Duration(
        milliseconds: 60000,
      ),
      contentType: 'application/json; charset=utf-8',
    ),
  );

  getIt.registerLazySingleton<AWalletConfig>(
    () => config,
  );

  getIt.registerFactory<Dio>(
    () => dio,
  );

  WalletCore.init();

  const FlutterSecureStorage secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: AppLocalConstant.secureStorageName,
      preferencesKeyPrefix: AppLocalConstant.secureStoragePrefix,
    ),
    iOptions: IOSOptions(),
  );

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Set web3 auth redirect uri
  // Must replace late
  Uri redirectUrl;
  if (Platform.isAndroid) {
    redirectUrl = Uri.parse(config.config.web3Auth.androidRedirectUrl);
  } else {
    redirectUrl = Uri.parse(config.config.web3Auth.iosRedirectUrl);
  }

  await Web3AuthFlutter.init(
    Web3AuthOptions(
      clientId: config.config.web3Auth.clientId,
      network: Network.sapphire_devnet,
      redirectUrl: redirectUrl,
    ),
  );

  final appNetwork = createNetwork(config);

  getIt.registerLazySingleton<AppNetwork>(
    () => appNetwork,
  );

  // Register observers
  getIt.registerLazySingleton<HomePageObserver>(
    () => HomePageObserver(),
  );

  getIt.registerLazySingleton<WalletPageObserver>(
    () => WalletPageObserver(),
  );

  // Register generator
  getIt.registerLazySingleton<RemoteTokenMarketServiceGenerator>(
    () => RemoteTokenMarketServiceGenerator(
      getIt.get<Dio>(),
      baseUrl: config.config.api.v1.url,
    ),
  );

  getIt.registerLazySingleton<BalanceServiceGenerator>(
    () => BalanceServiceGenerator(
      getIt.get<Dio>(),
    ),
  );

  getIt.registerLazySingleton<NFTServiceGenerator>(
    () => NFTServiceGenerator(
      getIt.get<Dio>(),
    ),
  );

  // Register service
  getIt.registerLazySingleton<LocalizationService>(
    () => LocalizationServiceImpl(
      sharedPreferences,
    ),
  );

  getIt.registerLazySingleton<BiometricProvider>(
    () => BiometricProviderImpl(),
  );

  getIt.registerLazySingleton<NormalStorageService>(
    () => NormalStorageServiceImpl(sharedPreferences),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => const SecureStorageServiceImpl(secureStorage),
  );

  getIt.registerLazySingleton<AccountDatabaseService>(
    () => AccountDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<KeyStoreDatabaseService>(
    () => KeyStoreDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<TokenMarketDatabaseService>(
    () => TokenMarketDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<BrowserDatabaseService>(
    () => BrowserDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<BookMarkDatabaseService>(
    () => BookMarkDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<RemoteTokenMarketService>(
    () => RemoteTokenMarketServiceImpl(
      getIt.get<RemoteTokenMarketServiceGenerator>(),
    ),
  );

  getIt.registerLazySingleton<Web3AuthProvider>(
    () => const Web3AuthProviderImpl(),
  );

  getIt.registerLazySingleton<BalanceDatabaseService>(
    () => BalanceDatabaseServiceImpl(isar),
  );

  getIt.registerLazySingleton<BalanceService>(
    () => BalanceServiceImpl(
      getIt.get<BalanceServiceGenerator>(),
    ),
  );

  getIt.registerLazySingleton<NftService>(
    () => NftServiceImpl(
      getIt.get<NFTServiceGenerator>(),
    ),
  );

  getIt.registerLazySingleton<TokenDatabaseService>(
    () => TokenDatabaseServiceImpl(
      isar,
    ),
  );

  getIt.registerLazySingleton<AddressBookDatabaseService>(
    () => AddressBookDatabaseServiceImpl(
      isar,
    ),
  );

  // Register repository
  getIt.registerLazySingleton<LocalizationRepository>(
    () => LocalizationRepositoryImpl(
      getIt.get<LocalizationService>(),
    ),
  );

  getIt.registerLazySingleton<AppSecureRepository>(
    () => AppSecureRepositoryImpl(
      getIt.get<NormalStorageService>(),
      getIt.get<BiometricProvider>(),
    ),
  );

  getIt.registerLazySingleton<KeyStoreRepository>(
    () => KeyStoreRepositoryImpl(
      getIt.get<KeyStoreDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      getIt.get<AccountDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<Web3AuthRepository>(
    () => Web3AuthRepositoryImpl(
      getIt.get<Web3AuthProvider>(),
    ),
  );

  getIt.registerLazySingleton<TokenMarketRepository>(
    () => TokenMarketRepositoryImpl(
      getIt.get<RemoteTokenMarketService>(),
      getIt.get<TokenMarketDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<BalanceRepository>(
    () => BalanceRepositoryImpl(
      getIt.get<BalanceService>(),
      getIt.get<BalanceDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<NftRepository>(
    () => NftRepositoryImpl(
      getIt.get<NftService>(),
    ),
  );

  getIt.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(
      getIt.get<TokenDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<BrowserManagementRepository>(
    () => BrowserManagementRepositoryImpl(
      getIt.get<BrowserDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<BookMarkRepository>(
    () => BookMarkRepositoryImpl(
      getIt.get<BookMarkDatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<AddressBookRepository>(
    () => AddressBookRepositoryImpl(
      getIt.get<AddressBookDatabaseService>(),
    ),
  );

  // Register use case
  getIt.registerLazySingleton<LocalizationUseCase>(
    () => LocalizationUseCase(
      getIt.get<LocalizationRepository>(),
    ),
  );

  getIt.registerLazySingleton<AppSecureUseCase>(
    () => AppSecureUseCase(
      getIt.get<AppSecureRepository>(),
    ),
  );

  getIt.registerLazySingleton<KeyStoreUseCase>(
    () => KeyStoreUseCase(
      getIt.get<KeyStoreRepository>(),
    ),
  );

  getIt.registerLazySingleton<AccountUseCase>(
    () => AccountUseCase(
      getIt.get<AccountRepository>(),
    ),
  );

  getIt.registerLazySingleton<Web3AuthUseCase>(
    () => Web3AuthUseCase(
      getIt.get<Web3AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<TokenMarketUseCase>(
    () => TokenMarketUseCase(
      getIt.get<TokenMarketRepository>(),
    ),
  );

  getIt.registerLazySingleton<BalanceUseCase>(
    () => BalanceUseCase(
      getIt.get<BalanceRepository>(),
    ),
  );

  getIt.registerLazySingleton<NftUseCase>(
    () => NftUseCase(
      getIt.get<NftRepository>(),
    ),
  );

  getIt.registerLazySingleton<TokenUseCase>(
    () => TokenUseCase(
      getIt.get<TokenRepository>(),
    ),
  );

  getIt.registerLazySingleton<BrowserManagementUseCase>(
    () => BrowserManagementUseCase(
      getIt.get<BrowserManagementRepository>(),
    ),
  );

  getIt.registerLazySingleton<BookMarkUseCase>(
    () => BookMarkUseCase(
      getIt.get<BookMarkRepository>(),
    ),
  );

  getIt.registerLazySingleton<AddressBookUseCase>(
    () => AddressBookUseCase(
      getIt.get<AddressBookRepository>(),
    ),
  );

  // Register bloc
  getIt.registerFactory<CreatePasscodeCubit>(
    () => CreatePasscodeCubit(
      getIt.get<AppSecureUseCase>(),
    ),
  );

  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(
      getIt.get(),
      getIt.get(),
    ),
  );

  getIt.registerFactory<GenerateWalletCubit>(
    () => GenerateWalletCubit(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
    ),
  );

  getIt.registerFactory<ReLoginCubit>(
    () => ReLoginCubit(
      getIt.get<AppSecureUseCase>(),
      getIt.get<AccountUseCase>(),
    ),
  );

  getIt.registerFactory<ImportWalletBloc>(
    () => ImportWalletBloc(),
  );

  getIt.registerFactoryParam<ImportWalletYetiBotCubit, AWallet, dynamic>(
    (wallet, _) => ImportWalletYetiBotCubit(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
      wallet: wallet,
    ),
  );

  getIt.registerFactory<GetStartedCubit>(
    () => GetStartedCubit(
      getIt.get<Web3AuthUseCase>(),
    ),
  );

  getIt.registerFactoryParam<SocialLoginYetiBotCubit, AWallet, dynamic>(
    (wallet, _) => SocialLoginYetiBotCubit(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
      wallet: wallet,
    ),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt.get<AccountUseCase>(),
    ),
  );

  getIt.registerFactoryParam<HomePageBloc, AWalletConfig, dynamic>(
    (config, _) => HomePageBloc(
      getIt.get<TokenUseCase>(),
      getIt.get<AccountUseCase>(),
      getIt.get<TokenMarketUseCase>(),
      getIt.get<BalanceUseCase>(),
      config: config,
    ),
  );

  getIt.registerFactory<SendBloc>(
    () => SendBloc(
      getIt.get<TokenUseCase>(),
      getIt.get<AccountUseCase>(),
      getIt.get<BalanceUseCase>(),
      getIt.get<TokenMarketUseCase>(),
      getIt.get<AddressBookUseCase>(),
    ),
  );

  getIt.registerFactoryParam<ConfirmSendBloc, AWalletConfig,
      Map<String, dynamic>>(
    (config, arguments) => ConfirmSendBloc(getIt.get<KeyStoreUseCase>(),
        config: config,
        recipient: arguments['recipient'],
        balance: arguments['balance'],
        amount: arguments['amount'],
        account: arguments['account'],
        appNetwork: arguments['network'],
        tokens: arguments['tokens']),
  );

  getIt.registerFactory<ManageTokenBloc>(
    () => ManageTokenBloc(
      getIt.get<TokenUseCase>(),
    ),
  );

  getIt.registerFactory<BrowserPageBloc>(
    () => BrowserPageBloc(
      getIt.get<BrowserManagementUseCase>(),
      getIt.get<BookMarkUseCase>(),
    ),
  );

  getIt.registerFactoryParam<BrowserBloc, String, dynamic>(
    (initUrl, _) => BrowserBloc(
      getIt.get<AccountUseCase>(),
      getIt.get<BrowserManagementUseCase>(),
      getIt.get<BookMarkUseCase>(),
      initUrl: initUrl,
    ),
  );

  getIt.registerFactory<BrowserSearchBloc>(
    () => BrowserSearchBloc(),
  );

  getIt.registerFactory<BrowserTabManagementBloc>(
    () => BrowserTabManagementBloc(
      getIt.get<BrowserManagementUseCase>(),
    ),
  );

  getIt.registerFactoryParam<NFTBloc, AWalletConfig, dynamic>(
    (config, _) => NFTBloc(
      getIt.get<NftUseCase>(),
      getIt.get<AccountUseCase>(),
      config: config,
    ),
  );

  getIt.registerFactory<NftTransferBloc>(
    () => NftTransferBloc(
      getIt.get<AccountUseCase>(),
      getIt.get<AddressBookUseCase>(),
    ),
  );

  getIt.registerFactoryParam<ConfirmTransferNftBloc, AWalletConfig,
      Map<String, dynamic>>(
    (config, argument) => ConfirmTransferNftBloc(
      getIt.get<KeyStoreUseCase>(),
      nft: argument['nft'],
      account: argument['account'],
      appNetwork: argument['network'],
      recipient: argument['recipient'],
      config: config,
    ),
  );

  getIt.registerFactory<AddressBookBloc>(
    () => AddressBookBloc(
      getIt.get<AddressBookUseCase>(),
    ),
  );

  getIt.registerFactory<SettingPasscodeAndBiometricCubit>(
    () => SettingPasscodeAndBiometricCubit(
      getIt.get<AppSecureUseCase>(),
    ),
  );

  getIt.registerFactory<SettingChangePasscodeCubit>(
    () => SettingChangePasscodeCubit(
      getIt.get<AppSecureUseCase>(),
    ),
  );

  getIt.registerFactory<WalletCubit>(
    () => WalletCubit(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
      getIt.get<Web3AuthUseCase>(),
    ),
  );

  getIt.registerFactory<SignedImportWalletBloc>(
    () => SignedImportWalletBloc(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
    ),
  );

  getIt.registerFactory<SettingCubit>(
    () => SettingCubit(
      getIt.get<AccountUseCase>(),
      getIt.get<KeyStoreUseCase>(),
      getIt.get<TokenUseCase>(),
      getIt.get<BookMarkUseCase>(),
      getIt.get<BrowserManagementUseCase>(),
      getIt.get<AddressBookUseCase>(),
      getIt.get<BalanceUseCase>(),
    ),
  );
}

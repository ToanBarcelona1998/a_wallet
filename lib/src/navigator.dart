import 'package:a_wallet/src/core/app_routes.dart';
import 'package:a_wallet/src/presentation/screens/address_book/address_book_screen.dart';
import 'package:a_wallet/src/presentation/screens/browser/browser_screen.dart';
import 'package:a_wallet/src/presentation/screens/browser_search/browser_search_screen.dart';
import 'package:a_wallet/src/presentation/screens/browser_tab_management/browser_tab_management_screen.dart';
import 'package:a_wallet/src/presentation/screens/confirm_send/confirm_send_screen.dart';
import 'package:a_wallet/src/presentation/screens/confirm_transfer_nft/confirm_transfer_nft_screen.dart';
import 'package:a_wallet/src/presentation/screens/create_passcode/create_passcode_screen.dart';
import 'package:a_wallet/src/presentation/screens/generate_wallet/generate_wallet_creen.dart';
import 'package:a_wallet/src/presentation/screens/get_started/get_started_screen.dart';
import 'package:a_wallet/src/presentation/screens/home/home_screen.dart';
import 'package:a_wallet/src/presentation/screens/import_wallet/import_wallet_screen.dart';
import 'package:a_wallet/src/presentation/screens/import_wallet_yeti_bot/import_wallet_yeti_bot_screen.dart';
import 'package:a_wallet/src/presentation/screens/manage_token/manage_token_screen.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_screen.dart';
import 'package:a_wallet/src/presentation/screens/nft_detail/nft_detail_screen.dart';
import 'package:a_wallet/src/presentation/screens/nft_transfer/nft_transfer_screen.dart';
import 'package:a_wallet/src/presentation/screens/re_login/re_login_screen.dart';
import 'package:a_wallet/src/presentation/screens/scan/scanner_screen.dart';
import 'package:a_wallet/src/presentation/screens/send/send_screen.dart';
import 'package:a_wallet/src/presentation/screens/setting_change_passcode/setting_change_passcode_screen.dart';
import 'package:a_wallet/src/presentation/screens/setting_passcode_and_biometric/setting_passcode_and_biometric_screen.dart';
import 'package:a_wallet/src/presentation/screens/social_login_yeti_bot/social_login_yeti_bot_screen.dart';
import 'package:a_wallet/src/presentation/screens/splash/spash_screen.dart';
import 'package:a_wallet/src/presentation/screens/transaction_result/transaction_result_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:wallet_core/wallet_core.dart';

// This class contains static route paths for the application.
sealed class RoutePath {
  static const String _base = '/';
  static const String splash = _base; // Root path for splash screen

  static const String _onBoarding = '${_base}onboarding';
  static const String reLogin = '$_onBoarding/re_login';
  static const String getStarted = '$_onBoarding/get_started';
  static const String setPasscode = '$_onBoarding/set_passcode';
  static const String createWallet = '$_onBoarding/create_wallet';
  static const String importWallet = '$_onBoarding/import_wallet';
  static const String importWalletYetiBot =
      '$_onBoarding/import_wallet_yeti_bot';
  static const String socialLoginYetiBot = '$_onBoarding/social_login_yeti_bot';

  static const String home = '${_base}home'; // Home path

  static const String send = '$home/send';
  static const String confirmSend = '$send/confirm';
  static const String transactionResult = '$home/transaction_result';

  static const String manageToken = '$home/manage_token';

  static const String scan = '$home/scan';

  static const String browser = '$home/browser';
  static const String browserSearch = '$home/search';
  static const String browserTabManagement = '$home/tab_management';

  static const String nft = '$home/nft';
  static const String nftDetail = '$nft/detail';

  static const String _setting = '$home/setting';

  static const String addressBook = '$_setting/address_book';

  static const String settingPassCodeAndBioMetric =
      '$_setting/setting_change_passcode_and_biometric';

  static const String settingChangePassCode =
      '$settingPassCodeAndBioMetric/change_passcode';

  static const String nftTransfer = '$nftDetail/transfer';
  static const String confirmTransferNft = '$nftTransfer/confirm';
}

// This class handles navigation within the application.
sealed class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // This function handles route generation based on the route settings.
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.splash:
        return _defaultRoute(
          const SplashScreen(),
          settings,
        );
      case RoutePath.getStarted:
        return _defaultRoute(
          const GetStartedScreen(),
          settings,
        );
      case RoutePath.setPasscode:
        final Map<String, dynamic> argument =
            settings.arguments as Map<String, dynamic>;
        final void Function(BuildContext context) onCreatePasscodeDone =
            argument['callback'] as void Function(BuildContext);

        final bool canBack = argument['canBack'] as bool? ?? true;
        return _defaultRoute(
          CreatePasscodeScreen(
            onCreatePasscodeDone: onCreatePasscodeDone,
            canBack: canBack,
          ),
          settings,
        );
      case RoutePath.reLogin:
        return _defaultRoute(
          const ReLoginScreen(),
          settings,
        );
      case RoutePath.createWallet:
        return _defaultRoute(
          const GenerateWalletScreen(),
          settings,
        );
      case RoutePath.home:
        return _defaultRoute(
          const HomeScreen(),
          settings,
        );
      case RoutePath.importWallet:
        return _defaultRoute(
          const ImportWalletScreen(),
          settings,
        );
      case RoutePath.importWalletYetiBot:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _defaultRoute(
          ImportWalletYetiBotScreen(
            aWallet: arguments['wallet'],
          ),
          settings,
        );
      case RoutePath.socialLoginYetiBot:
        final AWallet aWallet = settings.arguments as AWallet;
        return _defaultRoute(
          SocialLoginYetiBotScreen(
            aWallet: aWallet,
          ),
          settings,
        );
      case RoutePath.send:
        return _defaultRoute(
          const SendScreen(),
          settings,
        );

      case RoutePath.confirmSend:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _defaultRoute(
          ConfirmSendScreen(
            appNetwork: arguments['appNetwork'],
            account: arguments['account'],
            amount: arguments['amount'],
            recipient: arguments['recipient'],
            balance: arguments['balance'],
            tokens: arguments['tokens'],
          ),
          settings,
        );

      case RoutePath.transactionResult:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _defaultRoute(
          TransactionResultScreen(
            time: arguments['time'],
            amount: arguments['amount'],
            from: arguments['from'],
            hash: arguments['hash'],
            to: arguments['to'],
          ),
          settings,
        );
      case RoutePath.manageToken:
        return _defaultRoute(
          const ManageTokenScreen(),
          settings,
        );
      case RoutePath.scan:
        return _defaultRoute(
          const ScannerScreen(),
          settings,
        );
      case RoutePath.browser:
        final String url = settings.arguments as String;
        return _defaultRoute(
          BrowserScreen(
            initUrl: url,
          ),
          settings,
        );
      case RoutePath.browserSearch:
        return _defaultRoute(
          const BrowserSearchScreen(),
          settings,
        );
      case RoutePath.browserTabManagement:
        final bool closeAndReplace = settings.arguments as bool? ?? true;
        return _defaultRoute(
          BrowserTabManagementScreen(
            isCloseAndReplace: closeAndReplace,
          ),
          settings,
        );
      case RoutePath.nft:
        return _defaultRoute(
          const NFTScreen(),
          settings,
        );
      case RoutePath.nftDetail:
        final NFTInformation nftInformation =
            settings.arguments as NFTInformation;
        return _defaultRoute(
          NFTDetailScreen(
            nftInformation: nftInformation,
          ),
          settings,
        );
      case RoutePath.nftTransfer:
        final NFTInformation nftInformation =
            settings.arguments as NFTInformation;
        return _defaultRoute(
          NftTransferScreen(
            nft: nftInformation,
          ),
          settings,
        );
      case RoutePath.confirmTransferNft:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _defaultRoute(
          ConfirmTransferNftScreen(
            appNetwork: arguments['network'],
            account: arguments['account'],
            recipient: arguments['recipient'],
            nft: arguments['nft'],
          ),
          settings,
        );
      case RoutePath.addressBook:
        return _defaultRoute(
          const AddressBookScreen(),
          settings,
        );
      case RoutePath.settingChangePassCode:
        return _defaultRoute(
          const SettingChangePasscodeScreen(),
          settings,
        );
      case RoutePath.settingPassCodeAndBioMetric:
        return _defaultRoute(
          const SettingPasscodeAndBiometricScreen(),
          settings,
        );
      default:
        return _defaultRoute(
          const SplashScreen(),
          settings,
        );
    }
  }

  // Pushes a named route onto the navigator.
  static Future? push<T>(String route, [T? arguments]) =>
      state?.pushNamed(route, arguments: arguments);

  // Replaces the current route with a new one.
  static Future? replaceWith<T>(String route, [T? arguments]) =>
      state?.pushReplacementNamed(route, arguments: arguments);

  // Pops the top-most route off the navigator.
  static void pop<T>([T? arguments]) => state?.pop(arguments);

  // Pops routes until the specified route is reached.
  static void popUntil(String routeName) => state?.popUntil(
        (route) => route.settings.name == routeName,
      );

  // Pops all routes until the first one.
  static void popToFirst() => state?.popUntil((route) => route.isFirst);

  // Replaces all routes with the specified route.
  static void replaceAllWith(String route) =>
      state?.pushNamedAndRemoveUntil(route, (route) => false);

  // Gets the current state of the navigator.
  static NavigatorState? get state => navigatorKey.currentState;

  // Creates a default route with a slide transition.
  static Route _defaultRoute(
    Widget child,
    RouteSettings settings,
  ) {
    return SlideRoute(
      page: child,
      settings: settings,
    );
  }
}

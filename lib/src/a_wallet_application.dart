import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_cubit.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_state.dart';
import 'package:a_wallet/src/application/global/app_theme/cubit/app_theme_cubit.dart';
import 'package:a_wallet/src/application/global/localization/app_translations_delegate.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'dart:ui' as ui;

// Define the AuraWalletApplication widget
final class AWalletApplication extends StatefulWidget {
  const AWalletApplication({super.key});

  @override
  State<AWalletApplication> createState() => _AWalletApplicationState();
}

class _AWalletApplicationState extends State<AWalletApplication>
    with WidgetsBindingObserver {
  final PyxisMobileConfig _config = getIt.get<PyxisMobileConfig>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Handle different app lifecycle states
    switch (state) {
      case AppLifecycleState.inactive:
        // Handle inactive state
        break;
      case AppLifecycleState.resumed:
        // Handle resumed state
        break;
      case AppLifecycleState.detached:
        // Handle detached state
        break;
      case AppLifecycleState.paused:
        // Handle paused state
        break;
      case AppLifecycleState.hidden:
        // Handle hidden state
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Locale systemLocale = ui.PlatformDispatcher.instance.locale;
    AppLocalizationManager.instance
        .updateDeviceLocale(systemLocale.languageCode);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (WidgetsBinding.instance.focusManager.primaryFocus?.hasFocus ??
            false) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        navigatorKey: AppNavigator.navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: AppTypoGraPhy.mulish,
          tabBarTheme: const TabBarTheme(
            labelPadding: EdgeInsets.only(
              right: Spacing.spacing05,
            ),

          )
        ),
        onGenerateRoute: AppNavigator.onGenerateRoute,
        initialRoute: RoutePath.splash,
        debugShowCheckedModeBanner: false,
        title: _config.config.appName,
        locale: AppLocalizationManager.instance.getAppLocale(),
        localizationsDelegates: const [
          AppTranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizationManager.instance.supportedLang
            .map(
              (e) => Locale(e),
            )
            .toList(),
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (__) => AppThemeCubit(),
              ),
              BlocProvider(
                create: (_) => AppGlobalCubit(),
              ),
            ],
            child: Builder(
              builder: (builderContext) {
                return MultiBlocListener(
                  listeners: [
                    BlocListener<AppGlobalCubit, AppGlobalState>(
                      listenWhen: (previous, current) =>
                          current.status != previous.status,
                      listener: (context, state) {
                        // Listen to changes in AppGlobalState status
                        switch (state.status) {
                          case AppGlobalStatus.authorized:
                            // If the user is authorized, navigate to the home screen
                            AppNavigator.replaceAllWith(
                              RoutePath.home,
                            );
                            break;
                          case AppGlobalStatus.unauthorized:
                            // If the user is unauthorized, navigate to the get started screen
                            AppNavigator.replaceAllWith(
                              RoutePath.getStarted,
                            );
                            break;
                        }
                      },
                    ),
                  ],
                  child: Overlay(
                    initialEntries: [
                      OverlayEntry(
                        builder: (context) {
                          return child ?? const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

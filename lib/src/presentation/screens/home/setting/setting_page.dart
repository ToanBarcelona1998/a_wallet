import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/a_wallet_application.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_cubit.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_state.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/navigator.dart';
import 'widgets/language.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'setting_cubit.dart';
import 'setting_selector.dart';
import 'setting_state.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/option_widget.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with StateFulBaseScreen {
  final SettingCubit _cubit = getIt.get<SettingCubit>();

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingPageOptionWidget(
            onTap: () {
              AppNavigator.push(
                RoutePath.settingPassCodeAndBioMetric,
              );
            },
            appTheme: appTheme,
            localization: localization,
            iconPath: AssetIconPath.icCommonLock,
            labelPath: LanguageKey.settingsPagePasscode,
          ),
          SettingPageOptionWidget(
            onTap: () {
              AppNavigator.push(
                RoutePath.addressBook,
              );
            },
            appTheme: appTheme,
            localization: localization,
            iconPath: AssetIconPath.icCommonAddressBook,
            labelPath: LanguageKey.settingsPageAddressBook,
          ),
          SettingLanguagesSelector(
            builder: (languages) {
              return SettingCurrentLanguageSelector(
                builder: (currentLang) {
                  return SettingPageOptionWidget(
                    onTap: () {
                      _onSelectLanguage(
                        appTheme,
                        localization,
                        languages,
                        currentLang,
                      );
                    },
                    value: currentLang.toUpperCase(),
                    appTheme: appTheme,
                    localization: localization,
                    iconPath: AssetIconPath.icCommonLanguage,
                    labelPath: LanguageKey.settingsPageLanguage,
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: BoxSize.boxSize05,
          ),
          HoLiZonTalDividerWidget(
            appTheme: appTheme,
          ),
          const SizedBox(
            height: BoxSize.boxSize05,
          ),
          SettingPageOptionWidget(
            onTap: () {
              _cubit.onLogout();
            },
            appTheme: appTheme,
            localization: localization,
            iconPath: AssetIconPath.icCommonDelete,
            labelPath: LanguageKey.settingsPageLogout,
          ),
        ],
      ),
    );
  }

  @override
  Widget wrapBuild(
    BuildContext context,
    Widget child,
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<SettingCubit, SettingState>(
        listener: (context, state) {
          switch (state.status) {
            case SettingStatus.none:
              break;
            case SettingStatus.onLogout:
              break;
            case SettingStatus.logoutDone:
              AppGlobalCubit.of(context).changeStatus(
                AppGlobalStatus.unauthorized,
              );
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            localization: localization,
            isLeftActionActive: false,
            titleKey: LanguageKey.settingsPageTitle,
          ),
          body: child,
        ),
      ),
    );
  }

  void _onSelectLanguage(
    AppTheme appTheme,
    AppLocalizationManager localization,
    List<String> languages,
    String currentLang,
  ) async {
    final String? selectedLang =
        await AppBottomSheetProvider.showFullScreenDialog<String?>(
      context,
      child: SettingSelectLanguageWidget(
        appTheme: appTheme,
        localization: localization,
        languages: languages,
        currentLanguage: currentLang,
      ),
      appTheme: appTheme,
    );

    if (selectedLang != null) {
      _cubit.onChangeLanguage(
        selectedLang,
      );

     final aState = context.findAncestorStateOfType<AWalletApplicationState>();

     aState?.rebuild();
    }
  }
}

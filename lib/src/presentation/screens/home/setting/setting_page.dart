import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';

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
  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingPageOptionWidget(
            onTap: () {},
            appTheme: appTheme,
            localization: localization,
            iconPath: '',
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
            iconPath: '',
            labelPath: LanguageKey.settingsPageAddressBook,
          ),
          SettingPageOptionWidget(
            onTap: () {},
            appTheme: appTheme,
            localization: localization,
            iconPath: '',
            labelPath: LanguageKey.settingsPageLanguage,
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
            onTap: () {},
            appTheme: appTheme,
            localization: localization,
            iconPath: '',
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
    return Scaffold(
      backgroundColor: appTheme.bgPrimary,
      appBar: AppBarDefault(
        appTheme: appTheme,
        localization: localization,
        isLeftActionActive: false,
        titleKey: LanguageKey.settingsPageTitle,
      ),
      body: child,
    );
  }
}

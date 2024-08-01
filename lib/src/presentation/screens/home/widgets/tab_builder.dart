import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/screens/home/browser/browser_page.dart';
import 'package:a_wallet/src/presentation/screens/home/history/history_page.dart';
import 'package:a_wallet/src/presentation/screens/home/home/home_page.dart';
import 'package:a_wallet/src/presentation/screens/home/home_screen.dart';
import 'package:a_wallet/src/presentation/screens/home/setting/setting_page.dart';
import 'package:a_wallet/src/presentation/screens/home/wallet/wallet_page.dart';

class HomeScreenTabBuilder extends StatelessWidget {
  final HomeScreenSection currentSection;
  final void Function(Account, List<AppNetwork>,AppTheme,AppLocalizationManager) onReceivedTap;

  const HomeScreenTabBuilder({
    required this.currentSection,
    required this.onReceivedTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTab(
          HomeScreenSection.wallet,
          const WalletPage(),
        ),
        _buildTab(
          HomeScreenSection.browser,
          const BrowserPage(),
        ),
        _buildTab(
          HomeScreenSection.home,
          HomePage(
            onReceivedTap: onReceivedTap,
          ),
        ),
        _buildTab(
          HomeScreenSection.history,
          const HistoryPage(),
        ),
        _buildTab(
          HomeScreenSection.setting,
          const SettingPage(),
        ),
      ],
    );
  }

  Widget _buildTab(HomeScreenSection section, Widget widget) {
    final active = currentSection == section;

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !active,
        child: AnimatedOpacity(
          opacity: active ? 1 : 0,
          duration: const Duration(
            milliseconds: 200,
          ),
          child: widget,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
class BottomNavigatorBarWidget extends StatefulWidget {
  final AppTheme appTheme; // The app theme
  final AppLocalizationManager localization; // The app localization
  final int currentIndex; // The current selected index
  final void Function(int)
      onTabSelect; // Callback function when a tab is selectedlback function when the scan button is tapped

  const BottomNavigatorBarWidget({
    required this.currentIndex,
    required this.appTheme,
    required this.localization,
    required this.onTabSelect,
    super.key,
  });

  @override
  State<BottomNavigatorBarWidget> createState() =>
      _BottomNavigatorBarWidgetState();
}

class _BottomNavigatorBarWidgetState extends State<BottomNavigatorBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: Spacing.spacing05,
        bottom: Spacing.spacing07,
      ), // Padding for the container
      decoration: BoxDecoration(
        color: widget.appTheme.bgPrimary, // Background color
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 16, // Shadow blur radius
            spreadRadius: 0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            BorderRadiusSize
                .borderRadius05, // Border radius for top left corner
          ),
          topRight: Radius.circular(
            BorderRadiusSize
                .borderRadius05, // Border radius for top right corner
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 19,
            child: _buildItem(
              AssetIconPath
                  .icHomeScreenBottomNavigationBarWallet, // Icon path for home tab
              AssetIconPath.icHomeScreenBottomNavigationBarWallet,
              // Active icon path for home tab
              LanguageKey.homeScreenBottomNavigationBarWallet,
              // Localization key for home tab label
              () {
                widget.onTabSelect(
                    0); // Callback function when home tab is selected
              },
              widget.currentIndex ==
                  0, // Whether the home tab is currently selected
            ),
          ),
          Expanded(
            flex: 19,
            child: _buildItem(
              AssetIconPath.icHomeScreenBottomNavigationBarBrowser,
              // Icon path for home tab
              AssetIconPath.icHomeScreenBottomNavigationBarBrowser,
              // Active icon path for home tab
              LanguageKey.homeScreenBottomNavigationBarBrowser,
              // Localization key for home tab label
              () {
                widget.onTabSelect(
                    1); // Callback function when home tab is selected
              },
              widget.currentIndex ==
                  1, // Whether the home tab is currently selected
            ),
          ),
          Expanded(
            flex: 19,
            child: _buildItem(
              AssetIconPath
                  .icHomeScreenBottomNavigationBarHome, // Icon path for home tab
              AssetIconPath.icHomeScreenBottomNavigationBarHome,
              // Active icon path for home tab
              LanguageKey.homeScreenBottomNavigationBarHome,
              // Localization key for home tab label
                  () {
                widget.onTabSelect(
                    2); // Callback function when home tab is selected
              },
              widget.currentIndex ==
                  2, // Whether the home tab is currently selected
            ),
          ),
          Expanded(
            flex: 19,
            child: _buildItem(
              AssetIconPath
                  .icHomeScreenBottomNavigationBarHistory, // Icon path for history tab
              AssetIconPath.icHomeScreenBottomNavigationBarHistory,
              // Active icon path for history tab
              LanguageKey.homeScreenBottomNavigationBarHistory,
              // Localization key for history tab label
              () {
                widget.onTabSelect(
                    3); // Callback function when history tab is selected
              },
              widget.currentIndex ==
                  3, // Whether the history tab is currently selected
            ),
          ),
          Expanded(
            flex: 19,
            child: _buildItem(
              AssetIconPath
                  .icHomeScreenBottomNavigationBarSetting, // Icon path for setting tab
              AssetIconPath.icHomeScreenBottomNavigationBarSetting,
              // Active icon path for setting tab
              LanguageKey.homeScreenBottomNavigationBarSetting,
              // Localization key for setting tab label
              () {
                widget.onTabSelect(
                    4); // Callback function when setting tab is selected
              },
              widget.currentIndex ==
                  4, // Whether the setting tab is currently selected
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    String iconPath, // Icon path
    String activeIconPath, // Active icon path
    String labelPath, // Localization key for label
    VoidCallback onTap, // Callback function when the item is tapped
    bool isSelected, // Whether the item is currently selected
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected
                ? activeIconPath
                : iconPath, // Display active icon if the item is selected, otherwise display normal icon
          ),
          const SizedBox(
            height: BoxSize.boxSize04, // Spacer height
          ),
          Text(
            widget.localization.translate(
              labelPath, // Translate the label using localization provider
            ),
            style: AppTypoGraPhy.textXsSemiBold.copyWith(
              color: isSelected
                  ? widget.appTheme
                  .textTertiary // Text color for selected item
                  : widget.appTheme
                  .textTertiary, // Text color for normal item
            ),
          ),
        ],
      ),
    );
  }
}

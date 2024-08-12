import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

final class _SignedImportWalletTabWidget extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final AppTheme appTheme;
  final String text;
  final void Function(int)? onTap;

  const _SignedImportWalletTabWidget({
    required this.index,
    required this.selectedIndex,
    required this.appTheme,
    required this.text,
    this.onTap,
    super.key,
  });

  bool get _isSelected => index == selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(index),
      behavior: HitTestBehavior.opaque,
      child: _build(),
    );
  }

  Widget _child() {
    final TextStyle style = AppTypoGraPhy.textSmSemiBold.copyWith(
      color: _isSelected ? appTheme.textBrandPrimary : appTheme.textDisabled,
    );

    return Text(
      text,
      style: style,
    );
  }

  Widget _build() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing04,
        vertical: Spacing.spacing03,
      ),
      decoration: BoxDecoration(
        color: _isSelected ? appTheme.bgPrimary : appTheme.bgTertiary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius03,
        ),
      ),
      alignment: Alignment.center,
      child: _child(),
    );
  }
}

class SignedImportWalletTabWidget extends StatefulWidget {
  final AppTheme appTheme;
  final int selectedIndex;
  final AppLocalizationManager localization;
  final void Function(int)? onChanged;

  const SignedImportWalletTabWidget({
    required this.appTheme,
    required this.localization,
    this.selectedIndex = 0,
    this.onChanged,
    super.key,
  });

  @override
  State<SignedImportWalletTabWidget> createState() => _SignedImportWalletTabWidgetState();
}

class _SignedImportWalletTabWidgetState extends State<SignedImportWalletTabWidget> {
  AppTheme get appTheme => widget.appTheme;

  AppLocalizationManager get localization => widget.localization;

  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SignedImportWalletTabWidget oldWidget) {
    _selectedIndex = widget.selectedIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing02,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgTertiary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SignedImportWalletTabWidget(
              index: 0,
              selectedIndex: _selectedIndex,
              appTheme: appTheme,
              text: localization.translate(
                LanguageKey.signedImportWalletScreenSeedPhrase,
              ),
              onTap: _onTap,
            ),
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          Expanded(
            child: _SignedImportWalletTabWidget(
              index: 1,
              selectedIndex: _selectedIndex,
              appTheme: appTheme,
              text: localization.translate(
                LanguageKey.signedImportWalletScreenPrivateKey,
              ),
              onTap: _onTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(int index){
    if(index == _selectedIndex) return;

    _selectedIndex = index;

    setState(() {

    });

    widget.onChanged?.call(_selectedIndex);
  }
}

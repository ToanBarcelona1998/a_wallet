import 'package:flutter/cupertino.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';

class SwitchWidget extends StatelessWidget {
  final bool isSelected;
  final void Function(bool) onChanged;
  final AppTheme appTheme;

  const SwitchWidget({
    super.key,
    required this.onChanged,
    required this.isSelected,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isSelected,
      onChanged: onChanged,
      activeColor: appTheme.bgBrandSolid,
      trackColor: appTheme.bgQuaternary,
      thumbColor: appTheme.bgPrimary,
      offLabelColor: appTheme.bgQuaternary,
    );
  }
}

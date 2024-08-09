import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/utils/debounce.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'setting_passcode_and_biometric_cubit.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/switch_widget.dart';

import 'setting_passcode_and_biometric_selector.dart';
import 'widgets/setting_secure_option.dart';

class SettingPasscodeAndBiometricScreen extends StatefulWidget {
  const SettingPasscodeAndBiometricScreen({super.key});

  @override
  State<SettingPasscodeAndBiometricScreen> createState() =>
      _SettingPasscodeAndBiometricScreenState();
}

class _SettingPasscodeAndBiometricScreenState
    extends State<SettingPasscodeAndBiometricScreen>
    with CustomFlutterToast, StateFulBaseScreen {
  final SettingPasscodeAndBiometricCubit _cubit =
      getIt.get<SettingPasscodeAndBiometricCubit>();

  final Denounce<bool> _denounce = Denounce(
    const Duration(
      milliseconds: 1200,
    ),
  );

  void _onSetBioMetric(bool value) {
    _cubit.updateBio(value);
  }

  @override
  void initState() {
    _denounce.addObserver(_onSetBioMetric);
    super.initState();
  }

  @override
  void dispose() {
    _denounce.removeObserver(_onSetBioMetric);
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        SettingSecureOptionWidget(
          iconPath: AssetIconPath.icCommonLock,
          labelPath:
              LanguageKey.settingPasscodeScreenChangePasscode,
          appTheme: appTheme,
          onTap: () async {
            final status = await AppNavigator.push(
              RoutePath.settingChangePassCode,
            );

            if (status == true && context.mounted) {
              showSuccessToast(
                localization.translate(
                  LanguageKey
                      .settingPasscodeScreenSetNewPasscodeSuccessful,
                ),
              );
            }
          },
          prefix: SvgPicture.asset(
            AssetIconPath.icCommonArrowNext,
          ),
          localization: localization,
        ),
        SettingSecureOptionWidget(
          iconPath: AssetIconPath.icCommonLock,
          labelPath: LanguageKey.settingPasscodeScreenFaceId,
          appTheme: appTheme,
          onTap: () {},
          localization: localization,
          prefix: SettingPassCodeAndBioMetricAlReadyBioSelector(
            builder: (isSelected) {
              return SwitchWidget(
                onChanged: (value) async {
                  final bool verified = await _cubit.requestBioMetric();

                  if (verified) {
                    _cubit.onSetBio();
                  }

                  _denounce.onDenounce(verified);
                },
                isSelected: isSelected,
                appTheme: appTheme,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          titleKey: LanguageKey.settingPasscodeScreenAppBarTitle,
          localization: localization,
        ),
        body: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_cubit.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_state.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/navigator.dart';
import 'splash_cubit.dart';
import 'splash_state.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with StateFulBaseScreen {
  final AWalletConfig _config = getIt.get<AWalletConfig>();
  final SplashCubit _cubit = getIt.get<SplashCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(
          const Duration(seconds: 2),
        );
        _cubit.starting();
      },
    );
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetLogoPath.logo,
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        Text(
          _config.config.appName,
          style: AppTypoGraPhy.displayXsRegular.copyWith(
            color: appTheme.textPrimary,
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
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.starting:
              break;
            case SplashStatus.notHasPassCodeAndHasAccount:
              _onNotHasPasscodeAndHasAccount();
              break;
            case SplashStatus.hasAccountAndVerifyByBioSuccessful:
              _onChangeApplicationStatus(context);
              break;
            case SplashStatus.hasPassCode:
              AppNavigator.replaceWith(
                RoutePath.reLogin,
              );
              break;
            case SplashStatus.notHasPassCodeOrError:
              AppNavigator.replaceWith(
                RoutePath.getStarted,
              );
          }
        },
        child: Scaffold(
          body: Container(
            width: context.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appTheme.utilityCyan200,
                  appTheme.bgPrimary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  void _onNotHasPasscodeAndHasAccount() {
    AppNavigator.replaceWith(
      RoutePath.setPasscode,
      {
        'callback': _onChangeApplicationStatus,
        'canBack': false,
      },
    );
  }

  void _onChangeApplicationStatus(BuildContext context) {
    AppGlobalCubit.of(context).changeStatus(
      AppGlobalStatus.authorized,
    );
  }
}

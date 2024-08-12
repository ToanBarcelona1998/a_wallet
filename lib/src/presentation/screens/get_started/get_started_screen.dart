import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'package:a_wallet/src/navigator.dart';
import 'get_started_state.dart';
import 'get_started_cubit.dart';
import 'widgets/button_form.dart';
import 'widgets/logo_form.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with StateFulBaseScreen, CustomFlutterToast {
  final AWalletConfig _config = getIt.get<AWalletConfig>();

  final GetStartedCubit _cubit = getIt.get<GetStartedCubit>();

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: GetStartedLogoFormWidget(
            walletName: _config.config.appName,
            appTheme: appTheme,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        GetStartedButtonFormWidget(
          localization: localization,
          appTheme: appTheme,
          onCreateNewWallet: () {
            _onCheckHasPasscode(
                _onPushToCreateNew, _onReplacePasscodeToCreateNew);
          },
          onImportExistingWallet: () {
            _onCheckHasPasscode(_onPushToAddExistingWallet,
                _onReplacePasscodeToAddExistingWallet);
          },
          onTermClick: () {},
          onGoogleTap: () {
            _onSocialClick(
              Web3AuthLoginProvider.google,
            );
          },
          onTwitterTap: () {
            _onSocialClick(
              Web3AuthLoginProvider.twitter,
            );
          },
          onAppleTap: () {
            _onSocialClick(
              Web3AuthLoginProvider.apple,
            );
          },
        ),
      ],
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
      child: BlocListener<GetStartedCubit, GetStartedState>(
        listener: (context, state) {
          switch (state.status) {
            case GetStartedStatus.none:
              break;
            case GetStartedStatus.onSocialLogin:
              break;
            case GetStartedStatus.loginSuccess:
              AppNavigator.push(
                RoutePath.socialLoginYetiBot,
                state.wallet,
              );
              break;
            case GetStartedStatus.loginFailure:
              showToast(
                state.error.toString(),
              );
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          body: child,
        ),
      ),
    );
  }

  void _onCheckHasPasscode(
    VoidCallback hasPasscodeCallBack,
    void Function(BuildContext) nonPasscodeCallBack,
  ) async {
    final appSecureUseCase = getIt.get<AppSecureUseCase>();

    final bool hasPassCode = await appSecureUseCase.hasPasscode(
      key: AppLocalConstant.passCodeKey,
    );

    if (hasPassCode) {
      hasPasscodeCallBack.call();
    } else {
      AppNavigator.push(
        RoutePath.setPasscode,
        {
          'callback' : nonPasscodeCallBack,
          'canBack' : true,
        },
      );
    }
  }

  void _onPushToCreateNew() {
    AppNavigator.push(
      RoutePath.createWallet,
    );
  }

  void _onReplacePasscodeToCreateNew(BuildContext context) {
    AppNavigator.replaceWith(
      RoutePath.createWallet,
    );
  }

  void _onReplacePasscodeToAddExistingWallet(BuildContext context) {
    AppNavigator.replaceWith(
      RoutePath.importWallet,
    );
  }

  void _onPushToAddExistingWallet() {
    AppNavigator.push(
      RoutePath.importWallet,
    );
  }

  void _onSocialClick(Web3AuthLoginProvider provider) {
    _cubit.onLogin(provider);
  }
}

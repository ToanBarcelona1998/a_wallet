import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_cubit.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_state.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/navigator.dart';
import 're_login_cubit.dart';
import 're_login_state.dart';
import 'widgets/fill_passcode.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/key_board_number_widget.dart';

class ReLoginScreen extends StatefulWidget {
  const ReLoginScreen({super.key});

  @override
  State<ReLoginScreen> createState() => _ReLoginScreenState();
}

class _ReLoginScreenState extends State<ReLoginScreen> with StateFulBaseScreen {
  final ReLoginCubit _cubit = getIt.get<ReLoginCubit>();

  int _fillIndex = -1;

  //user input password
  final List<String> _passwords = List.empty(growable: true);

  Timer? _lockTimer;
  int _time = 120;

  void _onStartCountDownTimer() {
    _resetPasswordWhenLockTime();
    _lockTimer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) {
        _time--;

        setState(() {});

        if (_time == 0) {
          _resetLockTime();
          _cubit.unLockInputPassword();
        }
      },
    );
  }

  void _resetLockTime() {
    _lockTimer?.cancel();
    _time = 120;
  }

  void _resetPasswordWhenLockTime() {
    _passwords.clear();
    _fillIndex = -1;

    setState(() {});
  }

  @override
  void dispose() {
    _resetLockTime();
    super.dispose();
  }

  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: ReLoginFillPasscodeWidget(
            appTheme: appTheme,
            fillIndex: _fillIndex,
          ),
        ),
        KeyboardNumberWidget(
          onKeyboardTap: (text) {
            _onFillPassword(text);
          },
          rightButtonFn: () {
            _onClearPassword();
          },
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<ReLoginCubit, ReLoginState>(
        listener: (context, state) {
          switch (state.status) {
            case ReLoginStatus.none:
              break;
            case ReLoginStatus.hasAccounts:
              AppGlobalCubit.of(context).changeStatus(
                AppGlobalStatus.authorized,
              );
              break;

            case ReLoginStatus.nonHasAccounts:
              AppNavigator.replaceAllWith(
                RoutePath.getStarted,
              );
              break;
            case ReLoginStatus.wrongPassword:
              break;
            case ReLoginStatus.lockTime:
              _onStartCountDownTimer();
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

  void _onFillPassword(String text) {
    if (_fillIndex == 5) return;

    _passwords.add(text);

    _fillIndex++;

    setState(() {});

    if (_fillIndex == 5) {
      _cubit.userInputPassword(
        inputPasscode: _passwords.join(),
      );
    }
  }

  void _onClearPassword() {
    if (_fillIndex < 0) return;

    _fillIndex--;

    if (_passwords.isEmpty) return;
    _passwords.removeLast();

    setState(() {});
  }
}

import 'package:a_wallet/src/navigator.dart';
import 'widgets/confirm_passcode.dart';
import 'widgets/create_new.dart';
import 'widgets/enter_passcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/key_board_number_widget.dart';

import 'setting_change_passcode_cubit.dart';
import 'setting_change_passcode_state.dart';

class SettingChangePasscodeScreen extends StatefulWidget {
  const SettingChangePasscodeScreen({
    super.key,
  });

  @override
  State<SettingChangePasscodeScreen> createState() =>
      _SettingChangePasscodeScreenState();
}

class _SettingChangePasscodeScreenState
    extends State<SettingChangePasscodeScreen>
    with StateFulBaseScreen, SingleTickerProviderStateMixin {
  final SettingChangePasscodeCubit _cubit =
      getIt.get<SettingChangePasscodeCubit>();

  late PageController _pageController;

  int _fillIndex = -1;

  final List<String> _password = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: defaultPadding(),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SettingChangePasscodeScreenEnterPasscodeWidget(
                  appTheme: appTheme,
                  localization: localization,
                  fillIndex: _fillIndex,
                ),
                SettingChangePasscodeScreenCreateNewWidget(
                  appTheme: appTheme,
                  localization: localization,
                  fillIndex: _fillIndex,
                ),
                SettingChangePasscodeScreenConfirmWidget(
                  appTheme: appTheme,
                  localization: localization,
                  fillIndex: _fillIndex,
                ),
              ],
            ),
          ),
        ),
        KeyboardNumberWidget(
          rightButtonFn: _onClearPassword,
          onKeyboardTap: _onKeyBoardTap,
        ),
      ],
    );
  }

  @override
  EdgeInsets padding() {
    return EdgeInsets.zero;
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _cubit,
      child:
          BlocListener<SettingChangePasscodeCubit, SettingChangePasscodeState>(
        listener: (context, state) {
          switch (state.status) {
            case SettingChangePassCodeStatus.none:
              break;
            case SettingChangePassCodeStatus.enterPasscodeSuccessful:
              // Create this cache passcode
              _onClearPassCode();
              // Move to create page
              _onMoveToNextPage(1);
              break;
            case SettingChangePassCodeStatus.enterPasscodeWrong:
              break;
            case SettingChangePassCodeStatus.createNewPassCodeDone:
              // Create this cache passcode
              _onClearPassCode();
              // Move to confirm page
              _onMoveToNextPage(2);
              break;
            case SettingChangePassCodeStatus.confirmPasscodeWrong:
              break;
            case SettingChangePassCodeStatus.confirmPassCodeSuccessful:
              AppNavigator.pop(true);
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            localization: localization,
          ),
          body: child,
        ),
      ),
    );
  }

  void _onMoveToNextPage(int page) async {
    _pageController.animateToPage(
      page,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.bounceIn,
    );
  }

  void _onClearPassword() {
    if (_fillIndex < 0) return;

    _fillIndex--;

    if (_password.isEmpty) return;
    _password.removeLast();

    setState(() {});
  }

  void _onKeyBoardTap(String text) async {
    double? currentPage = _pageController.page;

    _fillIndex++;

    setState(() {});

    _password.add(text);

    VoidCallback callBack;

    if (currentPage == 0) {
      /// Enter passcode

      callBack = _onEnterPassCode;
    } else if (currentPage == 1) {
      callBack = _onCreatePassCode;
    } else {
      callBack = _onConfirmPassCode;
    }

    if (_fillIndex == 5) {
      callBack.call();
    }
  }

  void _onClearPassCode() {
    _fillIndex = -1;
    _password.clear();
    setState(() {});
  }

  void _onEnterPassCode() {
    _cubit.onEnterPasscodeDone(_password);
  }

  void _onCreatePassCode() {
    _cubit.onCreatePassCodeDone(_password);
  }

  void _onConfirmPassCode() {
    _cubit.onConfirmPassCodeDone(_password);
  }
}

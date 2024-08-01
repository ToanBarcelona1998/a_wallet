import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'create_passcode_state.dart';
import 'create_passcode_cubit.dart';
import 'widgets/fill_passcode.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/key_board_number_widget.dart';

class CreatePasscodeScreen extends StatefulWidget {
  final void Function(BuildContext) onCreatePasscodeDone;
  final bool canBack;

  const CreatePasscodeScreen({
    required this.onCreatePasscodeDone,
    this.canBack = true,
    super.key,
  });

  @override
  State<CreatePasscodeScreen> createState() => _CreatePasscodeScreenState();
}

class _CreatePasscodeScreenState extends State<CreatePasscodeScreen>
    with StateFulBaseScreen, SingleTickerProviderStateMixin {
  final CreatePasscodeCubit _cubit = getIt.get<CreatePasscodeCubit>();

  late PageController _pageController;

  int _fillIndex = -1;

  final List<String> _password = [];
  final List<String> _confirmPassword = [];

  bool _wrongConfirmPassword = false;

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
                CreatePasscodeCreateFormWidget(
                  appTheme: appTheme,
                  localization: localization,
                  fillIndex: _fillIndex,
                ),
                CreatePasscodeConfirmFormWidget(
                  appTheme: appTheme,
                  localization: localization,
                  fillIndex: _fillIndex,
                  isWrongPasscode: _wrongConfirmPassword,
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
      child: BlocListener<CreatePasscodeCubit, CreatePasscodeState>(
        listener: (context, state) {
          switch (state.status) {
            case CreatePasscodeStatus.init:
              break;
            case CreatePasscodeStatus.onSavePasscode:
              break;
            case CreatePasscodeStatus.savePasscodeDone:
              _onSavePassWordDone();
              break;
          }
        },
        child: PopScope(
          canPop: widget.canBack,
          child: Scaffold(
            backgroundColor: appTheme.bgPrimary,
            appBar: AppBarDefault(
              appTheme: appTheme,
              localization: localization,
              leading: widget.canBack ? null : const SizedBox.shrink(),
            ),
            body: child,
          ),
        ),
      ),
    );
  }

  void _onClearPassword() {
    if (_fillIndex < 0) return;

    _fillIndex--;

    if (_pageController.page == 0) {
      if (_password.isEmpty) return;
      _password.removeLast();
    } else {
      if (_confirmPassword.isEmpty) return;
      _confirmPassword.removeLast();
    }

    setState(() {});
  }

  void _onKeyBoardTap(String text) async {
    if (_pageController.page == 0) {
      /// create password
      _fillIndex++;

      _password.add(text);

      if (_fillIndex == 5) {
        _fillIndex = -1;
        _pageController.animateToPage(
          1,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.bounceIn,
        );
      }
    } else {
      /// confirm password
      _fillIndex++;

      _confirmPassword.add(text);
      if (_fillIndex == 5) {
        if (_confirmPassword.join() != _password.join()) {
          /// show unMatch wrong
          _wrongConfirmPassword = true;
        } else {
          _wrongConfirmPassword = false;
        }

        String passWord = _password.join();

        if (_wrongConfirmPassword) {
          setState(() {});

          return;
        }

        await _cubit.savePasscode(passWord);
      }
    }
    setState(() {});
  }

  void _onSavePassWordDone() {
    widget.onCreatePasscodeDone(context);
  }
}

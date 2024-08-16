import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_cubit.dart';
import 'package:a_wallet/src/application/global/app_global_state/app_global_state.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/copy.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'social_login_yeti_bot_state.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/yeti_bot_message_widget.dart';
import 'social_login_yeti_bot_cubit.dart';
import 'social_login_yeti_bot_selector.dart';
import 'widgets/app_bar_title.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:wallet_core/wallet_core.dart';

class SocialLoginYetiBotScreen extends StatefulWidget {
  final AWallet aWallet;

  const SocialLoginYetiBotScreen({
    required this.aWallet,
    super.key,
  });

  @override
  State<SocialLoginYetiBotScreen> createState() =>
      _SocialLoginYetiBotScreenState();
}

class _SocialLoginYetiBotScreenState extends State<SocialLoginYetiBotScreen>
    with StateFulBaseScreen, CustomFlutterToast, Copy {
  final List<YetiBotMessageObject> _messages = [];
  final GlobalKey<AnimatedListState> _messageKey = GlobalKey<AnimatedListState>();
  late SocialLoginYetiBotCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<SocialLoginYetiBotCubit>(param1: widget.aWallet);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addContent();
  }

  Future<void> _addContent() async {
    final localization = AppLocalizationManager.of(context);
    const messageDelays = [
      LanguageKey.socialLoginYetiBotScreenBotContentOne,
      LanguageKey.socialLoginYetiBotScreenBotContentTwo,
      LanguageKey.socialLoginYetiBotScreenBotContentThree,
      LanguageKey.socialLoginYetiBotScreenBotContentFour,
      LanguageKey.socialLoginYetiBotScreenBotContentFive,
    ];
        const List<int> messageTime = [200, 700, 2000, 3000, 1200, 300];


    for (var i = 0; i < messageDelays.length; i++) {
      await Future.delayed(Duration(milliseconds: messageTime[i]));
      _messages.insert(
        0,
        YetiBotMessageObject(
          data: localization.translate(messageDelays[i]),
          groupId: i == messageDelays.length - 1 ? 2 : i,
          type: i == messageDelays.length - 1 ? 1 : 0,
          object: i == messageDelays.length - 1 ? [
            _cubit.state.wallet.address,
          ]
              : [],
        ),
      );
      _messageKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    }

    _cubit.updateStatus(true);
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme, AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: _messageKey,
            padding: const EdgeInsets.symmetric(vertical: Spacing.spacing06),
            reverse: true,
            initialItemCount: _messages.length,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Spacing.spacing03),
                  child: YetiBotMessageBuilder(
                    appTheme: appTheme,
                    messageObject: _messages[index],
                    nextGroup: _messages.getIndex(index + 1)?.groupId,
                    onCopy: (value) => copy(value),
                    localization: localization,
                    lastGroup: _messages.getIndex(index - 1)?.groupId,
                  ),
                ),
              );
            },
          ),
        ),
        SocialLoginYetiBotIsReadySelector(
          builder: (isReady) {
            return PrimaryAppButton(
              onPress: _onNavigateToHome,
              text: localization.translate(isReady
                  ? LanguageKey.socialLoginYetiBotScreenOnBoard
                  : LanguageKey.socialLoginYetiBotScreenGenerating),
              isDisable: !isReady,
              leading: !isReady
                  ? SizedBox.square(
                      dimension: 19.2,
                      child: CircularProgressIndicator(color: appTheme.textDisabled),
                    )
                  : null,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme, AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<SocialLoginYetiBotCubit, SocialLoginYetiBotState>(
        listener: (context, state) {
          switch(state.status){
            case SocialLoginYetiBotStatus.none:
              break;
            case SocialLoginYetiBotStatus.storing:
              showLoading();
              break;
            case SocialLoginYetiBotStatus.stored:
              hideLoading();
              AppGlobalCubit.of(context).changeStatus(AppGlobalStatus.authorized);
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgSecondary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            localization: localization,
            title: SocialLoginYetiBotAppBarTitleWidget(appTheme: appTheme, localization: localization),
          ),
          body: child,
        ),
      ),
    );
  }

  void _onNavigateToHome() {
    _cubit.storeKey();
  }
}

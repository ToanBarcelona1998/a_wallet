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
import 'import_wallet_yeti_bot_state.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/yeti_bot_message_widget.dart';
import 'import_wallet_yeti_bot_cubit.dart';
import 'import_yeti_bot_selector.dart';
import 'widgets/app_bar_title.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:wallet_core/wallet_core.dart';

class ImportWalletYetiBotScreen extends StatefulWidget {
  final AWallet aWallet;

  const ImportWalletYetiBotScreen({
    required this.aWallet,
    super.key,
  });

  @override
  State<ImportWalletYetiBotScreen> createState() =>
      _ImportWalletYetiBotScreenState();
}

class _ImportWalletYetiBotScreenState extends State<ImportWalletYetiBotScreen>
    with StateFulBaseScreen, CustomFlutterToast, Copy {
  final List<YetiBotMessageObject> _messages = [];
  final GlobalKey<AnimatedListState> _messageKey =
      GlobalKey<AnimatedListState>();
  late ImportWalletYetiBotCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<ImportWalletYetiBotCubit>(
      param1: widget.aWallet,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addContent();
  }

  Future<void> _addContent() async {
    String displayAddress = widget.aWallet.address;

    final localization = AppLocalizationManager.of(context);
    const messageDelays = [
      LanguageKey.importWalletYetiBotScreenBotContentOne,
      LanguageKey.importWalletYetiBotScreenBotContentTwo,
      LanguageKey.importWalletYetiBotScreenBotContentThree,
      LanguageKey.importWalletYetiBotScreenBotContentFour,
      LanguageKey.importWalletYetiBotScreenBotContentFive,
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
          object: i == messageDelays.length - 1
              ? [
            displayAddress,
                ]
              : [],
        ),
      );
      _messageKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 300));
    }

    _cubit.updateStatus(true);
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
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
                  padding:
                      const EdgeInsets.symmetric(vertical: Spacing.spacing03),
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
        ImportWalletYetiBotIsReadySelector(
          builder: (isReady) {
            return PrimaryAppButton(
              onPress: _onNavigateToHome,
              text: localization.translate(isReady
                  ? LanguageKey.importWalletYetiBotScreenOnBoard
                  : LanguageKey.importWalletYetiBotScreenGenerating),
              isDisable: !isReady,
              leading: !isReady
                  ? SizedBox.square(
                      dimension: 19.2,
                      child: CircularProgressIndicator(
                          color: appTheme.textDisabled),
                    )
                  : null,
            );
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
      child: BlocListener<ImportWalletYetiBotCubit, ImportWalletYetiBotState>(
        listener: (context, state) {
          if (state.status == ImportWalletYetiBotStatus.stored) {
            AppGlobalCubit.of(context).changeStatus(AppGlobalStatus.authorized);
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgSecondary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            localization: localization,
            title: ImportWalletYetiBotAppBarTitleWidget(
                appTheme: appTheme, localization: localization),
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

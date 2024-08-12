import 'package:a_wallet/src/core/observer/wallet_page_observer.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/navigator.dart';
import 'widgets/select_word_dropdown.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'widgets/private_key.dart';
import 'widgets/seed_phrase.dart';
import 'package:a_wallet/src/presentation/widgets/fill_words_widget.dart';
import 'signed_import_wallet_bloc.dart';
import 'signed_import_wallet_state.dart';
import 'signed_import_wallet_event.dart';
import 'import_wallet_selector.dart';
import 'widgets/tab.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class SignedImportWalletScreen extends StatefulWidget {
  const SignedImportWalletScreen({
    super.key,
  });

  @override
  State<SignedImportWalletScreen> createState() =>
      _SignedImportWalletScreenState();
}

class _SignedImportWalletScreenState extends State<SignedImportWalletScreen>
    with StateFulBaseScreen {
  late SignedImportWalletBloc _bloc;

  final TextEditingController _privateKeyController = TextEditingController();

  final GlobalKey<FillWordsWidgetState> _passPhraseFormKey = GlobalKey();

  final WalletPageObserver _walletPageObserver =
      getIt.get<WalletPageObserver>();

  @override
  void initState() {
    _bloc = getIt.get<SignedImportWalletBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return SignedImportWalletStatusSelector(
      builder: (status) {
        return Column(
          children: [
            Expanded(
              child: SignedImportWalletControllerKeyTypeSelector(
                builder: (type) {
                  return Column(
                    children: [
                      SignedImportWalletTabWidget(
                        appTheme: appTheme,
                        localization: localization,
                        selectedIndex: type.index,
                        onChanged: _onChangeType,
                      ),
                      const SizedBox(
                        height: BoxSize.boxSize07,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: type == ControllerKeyType.passPhrase
                              ? SignedImportWalletWordCountSelector(
                                  builder: (count) {
                                    return SignedImportWalletSeedPhraseWidget(
                                      appTheme: appTheme,
                                      localization: localization,
                                      onPaste: _onPastePassPhrase,
                                      fillWordKey: _passPhraseFormKey,
                                      isValid: _bloc.isValidControllerKey,
                                      wordCount: count,
                                      onChangeWordClick: () =>
                                          _onChangeWordClick(
                                        appTheme,
                                        localization,
                                        count,
                                      ),
                                      onWordChanged: (key, _) =>
                                          _onControllerKeyChange(key),
                                    );
                                  },
                                )
                              : SignedImportWalletPrivateKeyWidget(
                                  appTheme: appTheme,
                                  localization: localization,
                                  controller: _privateKeyController,
                                  isValid: _bloc.isValidControllerKey,
                                  onChanged: (key, _) =>
                                      _onControllerKeyChange(key),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: BoxSize.boxSize05,
            ),
            PrimaryAppButton(
              text: localization.translate(
                LanguageKey.signedImportWalletScreenNext,
              ),
              onPress: _onSubmit,
              isDisable: status != SignedImportWalletStatus.isReadySubmit &&
                  status != SignedImportWalletStatus.imported,
              loading: status == SignedImportWalletStatus.importing,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<SignedImportWalletBloc, SignedImportWalletState>(
        listener: (context, state) {
          switch (state.status) {
            case SignedImportWalletStatus.none:
              break;
            case SignedImportWalletStatus.isReadySubmit:
              break;
            case SignedImportWalletStatus.importing:
              break;
            case SignedImportWalletStatus.imported:
              _walletPageObserver.emit(
                emitParam: WalletPageObserver.onImportedAccount,
              );
              AppNavigator.pop();
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            titleKey: LanguageKey.signedImportWalletScreenAppBarTitle,
            localization: localization,
          ),
          body: child,
        ),
      ),
    );
  }

  void _onChangeType(int index) {
    _bloc.add(
      SignedImportWalletOnChangeTypeEvent(
        type: ControllerKeyType.values[index],
      ),
    );
  }

  void _onPastePassPhrase() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

    if (data != null) {
      _passPhraseFormKey.currentState?.fillWord(data.text ?? '');
    }
  }

  void _onControllerKeyChange(String value) {
    _bloc.add(
      SignedImportWalletOnControllerKeyChangeEvent(
        controllerKey: value,
      ),
    );
  }

  void _onSubmit() {
    _bloc.add(
      const SignedImportWalletOnSubmitEvent(),
    );
  }

  void _onChangeWordClick(
    AppTheme appTheme,
    AppLocalizationManager localization,
    int currentWord,
  ) {
    AppBottomSheetProvider.showFullScreenDialog(
      context,
      child: SignedImportWalletSelectWordDropdownWidget(
        appTheme: appTheme,
        localization: localization,
        onSelected: _onChangeWord,
        currentWord: currentWord,
      ),
      appTheme: appTheme,
    );
  }

  void _onChangeWord(int wordCount) {
    _bloc.add(
      SignedImportWalletOnChangeWordCountEvent(
        wordCount: wordCount,
      ),
    );
  }
}

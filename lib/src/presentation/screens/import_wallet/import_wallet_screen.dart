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
import 'package:a_wallet/src/presentation/screens/import_wallet/widgets/select_word_dropdown.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'widgets/private_key.dart';
import 'widgets/seed_phrase.dart';
import 'package:a_wallet/src/presentation/widgets/fill_words_widget.dart';
import 'import_wallet_bloc.dart';
import 'import_wallet_state.dart';
import 'import_wallet_event.dart';
import 'import_wallet_selector.dart';
import 'widgets/tab.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class ImportWalletScreen extends StatefulWidget {
  const ImportWalletScreen({
    super.key,
  });

  @override
  State<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen>
    with StateFulBaseScreen {
  late ImportWalletBloc _bloc;

  final TextEditingController _privateKeyController = TextEditingController();

  final GlobalKey<FillWordsWidgetState> _passPhraseFormKey = GlobalKey();

  @override
  void initState() {
    _bloc = getIt.get<ImportWalletBloc>();
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
    return ImportWalletStatusSelector(
      builder: (status) {
        return Column(
          children: [
            Expanded(
              child: ImportWalletControllerKeyTypeSelector(
                builder: (type) {
                  return Column(
                    children: [
                      ImportWalletTabWidget(
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
                              ? ImportWalletWordCountSelector(
                                  builder: (count) {
                                    return ImportWalletSeedPhraseWidget(
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
                              : ImportWalletPrivateKeyWidget(
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
                LanguageKey.importWalletScreenNext,
              ),
              onPress: _onSubmit,
              isDisable: status != ImportWalletStatus.isReadySubmit &&
                  status != ImportWalletStatus.imported,
              loading: status == ImportWalletStatus.importing,
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
      child: BlocListener<ImportWalletBloc, ImportWalletState>(
        listener: (context, state) {
          switch (state.status) {
            case ImportWalletStatus.none:
              break;
            case ImportWalletStatus.isReadySubmit:
              break;
            case ImportWalletStatus.importing:
              break;
            case ImportWalletStatus.imported:
              AppNavigator.push(
                RoutePath.importWalletYetiBot,
                {
                  'wallet': state.aWallet,
                },
              );
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            titleKey: LanguageKey.importWalletScreenAppBarTitle,
            localization: localization,
          ),
          body: child,
        ),
      ),
    );
  }

  void _onChangeType(int index) {
    _bloc.add(
      ImportWalletOnChangeTypeEvent(
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
      ImportWalletOnControllerKeyChangeEvent(
        controllerKey: value,
      ),
    );
  }

  void _onSubmit() {
    _bloc.add(
      const ImportWalletOnSubmitEvent(),
    );
  }

  void _onChangeWordClick(
    AppTheme appTheme,
    AppLocalizationManager localization,
    int currentWord,
  ) {
    AppBottomSheetProvider.showFullScreenDialog(
      context,
      child: ImportWalletSelectWordDropdownWidget(
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
      ImportWalletOnChangeWordCountEvent(
        wordCount: wordCount,
      ),
    );
  }
}

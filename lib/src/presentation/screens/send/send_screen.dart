import 'package:a_wallet/src/core/helpers/scan_validator.dart';
import 'package:a_wallet/src/presentation/screens/send/widgets/select_contact.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/screens/send/send_selector.dart';
import 'package:a_wallet/src/presentation/screens/send/send_state.dart';
import 'package:a_wallet/src/presentation/screens/send/widgets/app_bar.dart';
import 'package:a_wallet/src/presentation/screens/send/widgets/select_token.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'send_event.dart';
import 'widgets/amount_widget.dart';
import 'widgets/from_widget.dart';
import 'widgets/to_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

import 'send_bloc.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen>
    with StateFulBaseScreen, CustomFlutterToast {
  late SendBloc _bloc;
  final AppNetwork _appNetwork = getIt.get<AppNetwork>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();

  @override
  void initState() {
    _bloc = getIt.get<SendBloc>();
    _bloc.add(
      const SendOnInitEvent(),
    );
    super.initState();
  }

  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: SendStatusSelector(
            builder: (status) {
              switch (status) {
                case SendStatus.loading:
                  return Center(
                    child: AppLoadingWidget(
                      appTheme: appTheme,
                    ),
                  );
                case SendStatus.loaded:
                case SendStatus.none:
                case SendStatus.reToken:
                case SendStatus.error:
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SendScreenFromWidget(
                          appTheme: appTheme,
                          localization: localization,
                          padding: defaultPadding(),
                        ),
                        Padding(
                          padding: defaultPadding(),
                          child: Column(
                            children: [
                              SendScreenToWidget(
                                appTheme: appTheme,
                                localization: localization,
                                onContactTap: (addressBooks) {
                                  _onOpenContact(appTheme, localization,addressBooks);
                                },
                                onScanTap: _onScan,
                                onChangeSaved: _onChangeSaved,
                                onAddressChanged: _onAddressChanged,
                                recipientController: _recipientController,
                                appNetwork: _appNetwork,
                              ),
                              const SizedBox(
                                height: BoxSize.boxSize07,
                              ),
                              SendScreenAmountToSendWidget(
                                appTheme: appTheme,
                                localization: localization,
                                onChanged: _onChangeAmount,
                                onSelectToken: (balances, selectedBalance,
                                    tokenMarkets, tokens) {
                                  _onSelectTokens(
                                    balances,
                                    selectedBalance,
                                    tokenMarkets,
                                    tokens,
                                    appTheme,
                                    localization,
                                  );
                                },
                                onMaxTap: (amount) {
                                  _onChangeAmount(amount, true);
                                  _amountController.text = amount;
                                },
                                amountController: _amountController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
        Padding(
          padding: defaultPadding(),
          child: SendAlreadySelector(
            builder: (already) {
              return PrimaryAppButton(
                text: localization.translate(
                  LanguageKey.sendScreenNext,
                ),
                isDisable: !already,
                onPress: _onSubmit,
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
      value: _bloc,
      child: BlocListener<SendBloc, SendState>(
        listener: (context, state) {
          switch (state.status) {
            case SendStatus.loading:
              break;
            case SendStatus.none:
              break;
            case SendStatus.loaded:
              break;
            case SendStatus.error:
              break;
            case SendStatus.reToken:
              _recipientController.text = '';
              _recipientController.text = '';
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            appTheme: appTheme,
            localization: localization,
            title: SendAppBar(
              appTheme: appTheme,
              localization: localization,
              appNetwork: _appNetwork,
            ),
          ),
          body: child,
        ),
      ),
    );
  }

  void _onChangeSaved(bool isSave) {
    _bloc.add(
      const SendOnChangeSavedEvent(),
    );
  }

  void _onAddressChanged(String address, bool isValid) {
    _bloc.add(
      SendOnChangeToEvent(
        address: address,
      ),
    );
  }

  void _onChangeAmount(String amount, bool isValid) {
    _bloc.add(
      SendOnChangeAmountEvent(
        amount: amount,
      ),
    );
  }

  void _onOpenContact(
    AppTheme appTheme,
    AppLocalizationManager localization,
    List<AddressBook> addressBooks,
  ) async {
    final selectedContact =
        await AppBottomSheetProvider.showFullScreenDialog<AddressBook?>(
      context,
      child: SendSelectContractWidget(
        appTheme: appTheme,
        localization: localization,
        addressBooks: addressBooks,
      ),
      appTheme: appTheme,
    );

    if(selectedContact != null){
      _recipientController.text = selectedContact.address;
    }
  }

  void _onSelectTokens(
    List<Balance> balances,
    Balance balance,
    List<TokenMarket> tokenMarkets,
    List<Token> tokens,
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) async {
    final selectedToken =
        await AppBottomSheetProvider.showFullScreenDialog<Balance?>(
      context,
      child: SendSelectTokensWidget(
        appTheme: appTheme,
        localization: localization,
        tokens: tokens,
        tokenMarkets: tokenMarkets,
        currentToken: balance,
        balances: balances,
      ),
      appTheme: appTheme,
    );

    if (selectedToken != null) {
      _bloc.add(
        SendOnChangeTokenEvent(
          selectedToken,
        ),
      );
    }
  }

  void _onScan()async{
    final ScanResult ? scanResult = await AppNavigator.push(RoutePath.scan);

    if(scanResult != null){
      _recipientController.text = scanResult.raw;
    }
  }

  void _onSubmit() {
    final state = _bloc.state;

    AppNavigator.push(RoutePath.confirmSend, {
      'appNetwork': _appNetwork,
      'account': state.account,
      'amount': state.amountToSend,
      'recipient': state.toAddress,
      'balance': state.selectedToken,
      'tokens': state.tokens,
    });
  }
}

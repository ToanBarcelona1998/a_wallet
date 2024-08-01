import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/observer/home_page_observer.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'package:a_wallet/src/navigator.dart';
import 'confirm_send_selector.dart';
import 'confirm_send_state.dart';
import 'widgets/message_form.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'package:a_wallet/src/presentation/widgets/change_fee_form_widget.dart';
import 'confirm_send_bloc.dart';
import 'confirm_send_event.dart';
import 'widgets/app_bar.dart';
import 'widgets/transaction_information.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

final class ConfirmSendScreen extends StatefulWidget {
  final AppNetwork appNetwork;
  final Account account;
  final String amount;
  final String recipient;
  final Balance balance;
  final List<Token> tokens;

  const ConfirmSendScreen({
    required this.appNetwork,
    required this.account,
    required this.amount,
    required this.recipient,
    required this.balance,
    required this.tokens,
    super.key,
  });

  @override
  State<ConfirmSendScreen> createState() => _ConfirmSendScreenState();
}

class _ConfirmSendScreenState extends State<ConfirmSendScreen>
    with StateFulBaseScreen, CustomFlutterToast {
  final PyxisMobileConfig _config = getIt.get<PyxisMobileConfig>();
  final HomePageObserver _homePageObserver = getIt.get<HomePageObserver>();
  late ConfirmSendBloc _bloc;

  Token? token;

  @override
  void initState() {
    token = widget.tokens.firstWhereOrNull(
      (t) => t.id == widget.balance.tokenId,
    );
    _bloc = getIt.get<ConfirmSendBloc>(
      param1: _config,
      param2: {
        'network': widget.appNetwork,
        'account': widget.account,
        'amount': widget.amount,
        'recipient': widget.recipient,
        'balance': widget.balance,
        'tokens': widget.tokens,
      },
    );

    _bloc.add(
      const ConfirmSendOnInitEvent(),
    );
    super.initState();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ConfirmSendScreenMessageFormWidget(
                    appTheme: appTheme,
                    localization: localization,
                    onChangeIsShowedMsg: _onChangeIsShowedMsg,
                    amount: widget.amount,
                    tokenName: token?.tokenName ?? '',
                    recipient: widget.recipient,
                    networkType: widget.appNetwork.type,
                  ),
                ),
              ),
              TransactionInformationWidget(
                accountName: widget.account.name,
                amount: widget.amount,
                from: widget.account.evmAddress,
                recipient: widget.recipient,
                appTheme: appTheme,
                token: token!,
                onEditFee: (gasPrice, gasEstimation) {
                  _onEditFee(
                    appTheme,
                    localization,
                    gasPrice.toDouble() * 1.25,
                    gasPrice.toDouble() * 0.75,
                    gasPrice.toDouble(),
                    gasEstimation.toDouble(),
                    token!,
                  );
                },
                localization: localization,
                balance: widget.balance,
              ),
            ],
          ),
        ),
        ConfirmSendStatusSelector(builder: (status) {
          return PrimaryAppButton(
            text: localization.translate(
              LanguageKey.confirmSendScreenConfirmSend,
            ),
            onPress: _onSubmit,
            loading: status == ConfirmSendStatus.sending,
          );
        }),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: _bloc,
        child: BlocListener<ConfirmSendBloc, ConfirmSendState>(
          listener: (context, state) {
            switch (state.status) {
              case ConfirmSendStatus.init:
                break;
              case ConfirmSendStatus.sending:
                showLoading();
                break;
              case ConfirmSendStatus.sent:
                _homePageObserver.emit(
                  emitParam: HomePageEmitParam(
                    event: HomePageObserver.onSendTokenDone,
                    data: token!.type,
                  ),
                );
                hideLoading();
                AppNavigator.push(
                  RoutePath.transactionResult,
                  {
                    'from': widget.account.evmAddress,
                    'to': widget.recipient,
                    'amount': widget.amount,
                    'time': state.timeStamp,
                    'hash': state.hash,
                  },
                );
                break;
              case ConfirmSendStatus.error:
                hideLoading();
                showToast(state.error ?? '');
                break;
            }
          },
          child: Scaffold(
            backgroundColor: appTheme.bgPrimary,
            appBar: AppBarDefault(
              appTheme: appTheme,
              localization: localization,
              title: ConfirmSendScreenAppBar(
                appTheme: appTheme,
                localization: localization,
                appNetwork: widget.appNetwork,
              ),
            ),
            body: child,
          ),
        ),
      ),
    );
  }

  void _onChangeIsShowedMsg() {
    _bloc.add(
      const ConfirmSendOnChangeIsShowedMessageEvent(),
    );
  }

  void _onEditFee(
    AppTheme appTheme,
    AppLocalizationManager localization,
    double max,
    double min,
    double currentValue,
    double estimationGas,
    Token token,
  ) async {
    final gasPrice = await AppBottomSheetProvider.showFullScreenDialog<double?>(
      context,
      child: ChangeFeeFormWidget(
        max: max,
        min: min,
        currentValue: currentValue,
        appTheme: appTheme,
        localization: localization,
        convertFee: (value) {
          return token.type.formatBalance(
            (value * estimationGas).toString(),
            customDecimal: token.decimal,
          );
        },
      ),
      appTheme: appTheme,
    );

    if (gasPrice != null) {
      _bloc.add(
        ConfirmSendOnChangeFeeEvent(
          gasPrice: gasPrice,
        ),
      );
    }
  }

  void _onSubmit() async {
    _bloc.add(
      const ConfirmSendOnSubmitEvent(),
    );
  }
}

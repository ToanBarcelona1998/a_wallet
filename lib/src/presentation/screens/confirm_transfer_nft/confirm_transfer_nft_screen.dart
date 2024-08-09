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
import 'package:a_wallet/src/core/utils/toast.dart';
import 'package:a_wallet/src/navigator.dart';
import 'confirm_send_bloc.dart';
import 'confirm_transfer_nft_event.dart';
import 'confirm_transfer_nft_selector.dart';
import 'confirm_transfer_nft_state.dart';
import 'widgets/message_form.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'package:a_wallet/src/presentation/widgets/change_fee_form_widget.dart';
import 'widgets/transaction_information.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

final class ConfirmTransferNftScreen extends StatefulWidget {
  final AppNetwork appNetwork;
  final Account account;
  final String recipient;
  final NFTInformation nft;

  const ConfirmTransferNftScreen({
    required this.appNetwork,
    required this.account,
    required this.recipient,
    required this.nft,
    super.key,
  });

  @override
  State<ConfirmTransferNftScreen> createState() =>
      _ConfirmTransferNftScreenState();
}

class _ConfirmTransferNftScreenState extends State<ConfirmTransferNftScreen>
    with StateFulBaseScreen, CustomFlutterToast {
  final AWalletConfig _config = getIt.get<AWalletConfig>();
  final HomePageObserver _homePageObserver = getIt.get<HomePageObserver>();
  late ConfirmTransferNftBloc _bloc;

  @override
  void initState() {
    _bloc = getIt.get<ConfirmTransferNftBloc>(
      param1: _config,
      param2: {
        'network': widget.appNetwork,
        'account': widget.account,
        'nft': widget.nft,
        'recipient': widget.recipient,
      },
    );

    _bloc.add(
      const ConfirmTransferNftOnInitEvent(),
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
                  child: ConfirmTransferNftScreenMessageFormWidget(
                    appTheme: appTheme,
                    localization: localization,
                    onChangeIsShowedMsg: _onChangeIsShowedMsg,
                    recipient: widget.recipient,
                    networkType: widget.appNetwork.type,
                    tokenId: widget.nft.tokenId,
                  ),
                ),
              ),
              ConfirmTransferNftInformationWidget(
                accountName: widget.account.name,
                from: widget.account.evmAddress,
                recipient: widget.recipient,
                appTheme: appTheme,
                onEditFee: (gasPrice, gasEstimation) {
                  _onEditFee(
                    appTheme,
                    localization,
                    gasPrice.toDouble() * 1.25,
                    gasPrice.toDouble() * 0.75,
                    gasPrice.toDouble(),
                    gasEstimation.toDouble(),
                  );
                },
                localization: localization,
              ),
            ],
          ),
        ),
        ConfirmTransferNftStatusSelector(
          builder: (status) {
            return PrimaryAppButton(
              text: localization.translate(
                LanguageKey.confirmTransferNftScreenConfirmSend,
              ),
              onPress: _onSubmit,
              loading: status == ConfirmTransferNftStatus.sending,
            );
          },
        ),
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
        child: BlocListener<ConfirmTransferNftBloc, ConfirmTransferNftState>(
          listener: (context, state) {
            switch (state.status) {
              case ConfirmTransferNftStatus.init:
                break;
              case ConfirmTransferNftStatus.sending:
                showLoading();
                break;
              case ConfirmTransferNftStatus.sent:
                _homePageObserver.emit(
                  emitParam: const HomePageEmitParam(
                    event: HomePageObserver.onSendTokenDone,
                    data: TokenType.native,
                  ),
                );
                hideLoading();
                AppNavigator.push(
                  RoutePath.transactionResult,
                  {
                    'from': widget.account.evmAddress,
                    'to': widget.recipient,
                    'amount': '0',
                    'time': state.timeStamp,
                    'hash': state.hash,
                  },
                );
                break;
              case ConfirmTransferNftStatus.error:
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
              titleKey: LanguageKey.confirmTransferNftScreenAppBarTitle,
            ),
            body: child,
          ),
        ),
      ),
    );
  }

  void _onChangeIsShowedMsg() {
    _bloc.add(
      const ConfirmTransferNftOnChangeIsShowedMessageEvent(),
    );
  }

  void _onEditFee(
    AppTheme appTheme,
    AppLocalizationManager localization,
    double max,
    double min,
    double currentValue,
    double estimationGas,
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
          return TokenType.native.formatBalance(
            (value * estimationGas).toString(),
          );
        },
      ),
      appTheme: appTheme,
    );

    if (gasPrice != null) {
      _bloc.add(
        ConfirmTransferNftOnChangeFeeEvent(
          gasPrice: gasPrice,
        ),
      );
    }
  }

  void _onSubmit() async {
    _bloc.add(
      const ConfirmTransferNftOnSubmitEvent(),
    );
  }
}

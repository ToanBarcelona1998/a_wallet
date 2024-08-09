import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/screens/nft_transfer/nft_transfer_state.dart';
import 'package:a_wallet/src/presentation/screens/nft_transfer/widgets/from_widget.dart';
import 'package:a_wallet/src/presentation/screens/nft_transfer/widgets/to_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:domain/domain.dart';
import 'nft_transfer_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nft_transfer_bloc.dart';
import 'nft_transfer_event.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:flutter/material.dart';

class NftTransferScreen extends StatefulWidget {
  final NFTInformation nft;

  const NftTransferScreen({
    required this.nft,
    super.key,
  });

  @override
  State<NftTransferScreen> createState() => _NftTransferScreenState();
}

class _NftTransferScreenState extends State<NftTransferScreen>
    with StateFulBaseScreen {
  final NftTransferBloc _bloc = getIt.get<NftTransferBloc>();
  final TextEditingController _recipientController = TextEditingController();

  final AppNetwork _appNetwork = getIt.get<AppNetwork>();

  @override
  void initState() {
    _bloc.add(
      const NftTransferOnInitEvent(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
  }

  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return NftTransferStatusSelector(
      builder: (status) {
        switch (status) {
          case NftTransferStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case NftTransferStatus.loaded:
          case NftTransferStatus.error:
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        NftTransferScreenFromWidget(
                          appTheme: appTheme,
                          localization: localization,
                          padding: defaultPadding(),
                        ),
                        Padding(
                          padding: defaultPadding(),
                          child: NftTransferScreenToWidget(
                            appTheme: appTheme,
                            localization: localization,
                            onContactTap: () {},
                            onScanTap: () {},
                            onAddressChanged: (address, _) {
                              _onChangeAddress(address);
                            },
                            recipientController: _recipientController,
                            appNetwork: _appNetwork,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                NftTransferAlreadySelector(
                  builder: (already) {
                    return Padding(
                      padding: defaultPadding(),
                      child: PrimaryAppButton(
                        text: localization.translate(
                          LanguageKey.nftTransferScreenNext,
                        ),
                        isDisable: !already,
                        onPress: _onNext,
                      ),
                    );
                  },
                ),
              ],
            );
        }
      },
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          localization: localization,
          titleKey: LanguageKey.nftTransferScreenAppBarTitle,
        ),
        body: child,
      ),
    );
  }

  void _onChangeAddress(String address) {
    _bloc.add(
      NftTransferOnChangeToEvent(
        address: address,
      ),
    );
  }

  void _onNext() {
    final state = _bloc.state;
    AppNavigator.push(RoutePath.confirmTransferNft, {
      'network': _appNetwork,
      'recipient': state.toAddress,
      'account': state.account,
      'nft': widget.nft,
    });
  }
}

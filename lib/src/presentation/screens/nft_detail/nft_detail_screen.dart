import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/utils/copy.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'widgets/nft_detail_information_widget.dart';
import 'widgets/nft_media_builder.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';

class NFTDetailScreen extends StatefulWidget {
  final NFTInformation nftInformation;

  const NFTDetailScreen({
    required this.nftInformation,
    super.key,
  });

  @override
  State<NFTDetailScreen> createState() => _NFTDetailScreenState();
}

class _NFTDetailScreenState extends State<NFTDetailScreen>
    with CustomFlutterToast, StateFulBaseScreen, Copy {
  final config = getIt.get<AWalletConfig>();

  void _onCopy() async {
    copy(widget.nftInformation.cw721Contract.smartContract.address);
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                NFTMediaBuilder(
                  mediaInfo: widget.nftInformation.mediaInfo.offChain,
                  appTheme: appTheme,
                ),
                const SizedBox(
                  height: BoxSize.boxSize06,
                ),
                NFTDetailInformationFormWidget(
                  name:
                      widget.nftInformation.mediaInfo.onChain.metadata?.name ??
                          '',
                  blockChain: widget.nftInformation.cw721Contract.name,
                  contractAddress:
                      widget.nftInformation.cw721Contract.smartContract.address,
                  appTheme: appTheme,
                  onCopy: _onCopy,
                  localization: localization,
                ),
              ],
            ),
          ),
        ),
        PrimaryAppButton(
          text: localization.translate(
            LanguageKey.nftDetailScreenTransfer,
          ),
          onPress: () => AppNavigator.push(
            RoutePath.nftTransfer,
            widget.nftInformation,
          ),
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Scaffold(
      backgroundColor: appTheme.bgPrimary,
      appBar: AppBarDefault(
        appTheme: appTheme,
        titleKey: '${widget.nftInformation.mediaInfo.onChain.metadata?.name}',
        localization: localization,
      ),
      body: child,
    );
  }
}

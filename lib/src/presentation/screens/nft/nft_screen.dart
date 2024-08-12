import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_selector.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'nft_bloc.dart';
import 'nft_event.dart';
import 'nft_state.dart';
import 'widgets/nft_layout_builder.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';

import 'widgets/nft_count_widget.dart';

class NFTScreen extends StatefulWidget {
  const NFTScreen({super.key});

  @override
  State<NFTScreen> createState() => _NFTScreenState();
}

class _NFTScreenState extends State<NFTScreen> with StateFulBaseScreen {
  late NFTBloc _bloc;
  final AWalletConfig _config = getIt.get<AWalletConfig>();

  @override
  void initState() {
    _bloc = getIt.get<NFTBloc>(
      param1: _config,
    );
    _bloc.add(
      const NFTEventOnInit(),
    );
    super.initState();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return NFTStatusSelector(
      builder: (status) {
        switch (status) {
          case NFTStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case NFTStatus.error:
          case NFTStatus.loaded:
          case NFTStatus.refresh:
          case NFTStatus.loadMore:
            return Column(
              children: [
                NFTScreenCountWidget(
                  appTheme: appTheme,
                  localization: localization,
                ),
                const SizedBox(
                  height: BoxSize.boxSize07,
                ),
                Expanded(
                  child: NFTScreenLayoutBuilder(
                    appTheme: appTheme,
                    localization: localization,
                  ),
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
          localization: localization,
          appTheme: appTheme,
          titleKey: LanguageKey.nftScreenAppBarTitle,
        ),
        body: child,
      ),
    );
  }
}

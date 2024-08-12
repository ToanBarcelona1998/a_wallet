import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'widgets/add.dart';
import 'package:domain/domain.dart';
import 'widgets/select_create_option.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wallet_cubit.dart';
import 'wallet_selector.dart';
import 'wallet_state.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:a_wallet/src/presentation/widgets/wallet_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with StateFulBaseScreen {
  final WalletCubit _cubit = getIt.get();

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return WalletStatusSelector(
      builder: (status) {
        switch (status) {
          case WalletStatus.none:
          case WalletStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case WalletStatus.loaded:
          case WalletStatus.error:
            return WalletAccountsSelector(
              builder: (accounts) {
                return CombinedListView(
                  onRefresh: () {},
                  onLoadMore: () {
                    //
                  },
                  data: accounts,
                  builder: (account, _) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: Spacing.spacing07,
                      ),
                      child: GestureDetector(
                        onTap: () {

                        },
                        behavior: HitTestBehavior.opaque,
                        child: DefaultWalletInfoWidget(
                          avatarAsset: randomAvatar(),
                          appTheme: appTheme,
                          title: account.name,
                          address: account.evmAddress,
                        ),
                      ),
                    );
                  },
                  canLoadMore: false,
                );
              },
            );
        }
      },
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          localization: localization,
          isLeftActionActive: false,
          titleKey: LanguageKey.walletPageAppBarTitle,
          actions: [
            GestureDetector(
              onTap: () {
                _onAddClick(appTheme, localization);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.spacing04,
                ),
                child: SvgPicture.asset(
                  AssetIconPath.icCommonAdd,
                ),
              ),
            ),
          ],
        ),
        body: child,
      ),
    );
  }

  void _onAddClick(
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) async {
    final type =
        await AppBottomSheetProvider.showFullScreenDialog<AccountCreateType?>(
      context,
      child: WalletSelectCreateOptionWidget(
        appTheme: appTheme,
        localization: localization,
      ),
      appTheme: appTheme,
    );

    switch (type) {
      case AccountCreateType.normal:
        final wallet = _cubit.createRandom();

        AppBottomSheetProvider.showFullScreenDialog(
          context,
          child: WalletAddNewWidget(
            appTheme: appTheme,
            localization: localization,
            address: wallet.address,
            onAdd: (name) {
              _cubit.onAdd(
                name,
                wallet,
              );
            },
            validator: (name) {
              return _cubit.state.accounts.firstWhereOrNull(
                    (a) => a.name == name,
                  ) ==
                  null;
            },
          ),
          appTheme: appTheme,
        );
        break;
      case AccountCreateType.import:
        break;
      case AccountCreateType.social:
        break;
      default:
        break;
    }
  }
}

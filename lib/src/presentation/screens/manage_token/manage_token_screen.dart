import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/screens/manage_token/widgets/token.dart';
import 'manage_token_event.dart';
import 'manage_token_bloc.dart';
import 'widgets/hide_balance.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class ManageTokenScreen extends StatefulWidget {
  const ManageTokenScreen({super.key});

  @override
  State<ManageTokenScreen> createState() => _ManageTokenScreenState();
}

class _ManageTokenScreenState extends State<ManageTokenScreen>
    with StateFulBaseScreen {
  final TextEditingController _searchController = TextEditingController();

  final ManageTokenBloc _bloc = getIt.get<ManageTokenBloc>();

  @override
  void initState() {
    _bloc.add(
      const ManageTokenOnInitEvent(),
    );
    super.initState();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        ManageTokenScreenHideSmallBalanceWidget(
          appTheme: appTheme,
          localization: localization,
          searchController: _searchController,
        ),
        Expanded(
          child: ManageTokenScreenTokensWidget(
            appTheme: appTheme,
            localization: localization,
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
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          localization: localization,
          titleKey: LanguageKey.manageTokenScreenAppBarTitle,
          actions: [
            Container(
              padding: const EdgeInsets.all(
                Spacing.spacing04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadiusRound,
                ),
                color: appTheme.utilityGray200,
              ),
              child: SvgPicture.asset(
                AssetIconPath.icCommonAdd,
              ),
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
          ],
        ),
        body: child,
      ),
    );
  }
}

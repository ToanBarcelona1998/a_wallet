import 'package:a_wallet/src/core/observer/home_page_observer.dart';
import 'package:a_wallet/src/core/utils/debounce.dart';
import 'package:domain/domain.dart';
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
import 'manage_token_state.dart';
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
  final HomePageObserver _homePageObserver = getIt.get<HomePageObserver>();

  late Denounce<Token> _denounce;

  @override
  void initState() {
    _denounce = Denounce(const Duration(
      milliseconds: 900,
    ));

    _denounce.addObserver(_onTokenChange);
    _bloc.add(
      const ManageTokenOnInitEvent(),
    );
    super.initState();
  }

  void _onTokenChange(Token token) {
    _bloc.add(
      ManageTokenOnDenounceDoneEvent(
        token,
      ),
    );
  }

  @override
  void dispose() {
    _denounce.removeObserver(_onTokenChange);
    _denounce.disPose();
    super.dispose();
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
          onChanged: (tokenName, _) {
            _bloc.add(
              ManageTokenOnSearchEvent(
                tokenName,
              ),
            );
          },
        ),
        Expanded(
          child: ManageTokenScreenTokensWidget(
            appTheme: appTheme,
            localization: localization,
            onChanged: (token) {
              _bloc.add(
                ManageTokenOnDenounceEvent(
                  token,
                ),
              );
              _denounce.onDenounce(token);
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
      child: BlocListener<ManageTokenBloc, ManageTokenState>(
        listener: (context, state) {
          switch (state.status) {
            case ManageTokenStatus.none:
              break;
            case ManageTokenStatus.error:
              break;
            case ManageTokenStatus.loading:
              break;
            case ManageTokenStatus.loaded:
              break;
            case ManageTokenStatus.onChangeDone:
              _homePageObserver.emit(
                emitParam: const HomePageEmitParam(
                  event: HomePageObserver.onMangedToken,
                ),
              );
              break;
          }
        },
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
      ),
    );
  }
}

import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'browser_search_selector.dart';
import 'browser_search_bloc.dart';
import 'browser_search_event.dart';
import 'widgets/browser_suggestion_widget.dart';
import 'widgets/google_suggestion_result_widget.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'widgets/search_widget.dart';

class BrowserSearchScreen extends StatefulWidget {
  const BrowserSearchScreen({super.key});

  @override
  State<BrowserSearchScreen> createState() => _BrowserSearchScreenState();
}

class _BrowserSearchScreenState extends State<BrowserSearchScreen>
    with StateFulBaseScreen {
  final TextEditingController _searchController = TextEditingController();

  final BrowserSearchBloc _bloc = getIt.get<BrowserSearchBloc>();

  String getGoogleQuery(String query) {
    return 'https://www.google.com/search?q=$query';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onClearSearch() {
    _searchController.clear();
    _bloc.add(
      const BrowserSearchOnQueryEvent(
        query: '',
      ),
    );
  }

  void _onChange(String value) {
    _bloc.add(
      BrowserSearchOnQueryEvent(
        query: value,
      ),
    );
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BrowserSearchWidget(
          controller: _searchController,
          appTheme: appTheme,
          onClear: _onClearSearch,
          onChanged: _onChange,
          localization: localization,
        ),
        BrowserSearchSystemsSelector(
          builder: (auraEcosystems) {
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                final browser = auraEcosystems[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: Spacing.spacing06,
                  ),
                  child: BrowserSearchEcosystemSuggestionWidget(
                    name: browser.name,
                    description: browser.description ?? '',
                    logo: browser.logo,
                    appTheme: appTheme,
                    onTap: () {
                      AppNavigator.replaceWith(
                        RoutePath.browser,
                        browser.url,
                      );
                    },
                  ),
                );
              },
              itemCount: auraEcosystems.length,
            );
          },
        ),
        BrowserSearchQuerySelector(
          builder: (query) {
            if (query.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                HoLiZonTalDividerWidget(
                  appTheme: appTheme,
                ),
                const SizedBox(
                  height: BoxSize.boxSize05,
                ),
                BrowserSearchGoogleSuggestionResultWidget(
                  description: localization.translate(
                    LanguageKey.browserSearchScreenSearchWithGoogle,
                  ),
                  appTheme: appTheme,
                  name: query,
                  onTap: () {
                    AppNavigator.replaceWith(
                      RoutePath.browser,
                      getGoogleQuery(
                        query,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          body: child,
        ),
      ),
    );
  }
}

import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_page_event.dart';
import 'browser_page_selector.dart';
import 'widgets/book_mark_more_action_widget.dart';
import 'browser_page_bloc.dart';
import 'widgets/browser_suggestion_widget.dart';
import 'widgets/tab_widget.dart';
import 'widgets/search_widget.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> with StateFulBaseScreen {
  final BrowserPageBloc _bloc = getIt.get<BrowserPageBloc>();

  // final HomeScreenObserver _homeScreenObserver =
  //     getIt.get<HomeScreenObserver>();
  //
  // void _registerEvent(HomeScreenEmitParam param) {
  //   if (param.event == HomeScreenObserver.onbrowserRefreshBookMarkEvent) {
  //     _bloc.add(
  //       const BrowserPageOnRefreshBookMarkEvent(),
  //     );
  //   } else if (param.event ==
  //       HomeScreenObserver.onbrowserRefreshBrowserEvent) {
  //     _bloc.add(
  //       const BrowserPageOnRefreshTabEvent(),
  //     );
  //   }
  // }

  @override
  void initState() {
    // _homeScreenObserver.addListener(_registerEvent);
    super.initState();
  }

  @override
  void dispose() {
    // _homeScreenObserver.removeListener(_registerEvent);
    super.dispose();
  }

  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Padding(
          padding: defaultPadding(),
          child: BrowserPageSearchWidget(
            appTheme: appTheme,
            onViewTap: () async {
              await AppNavigator.push(
                RoutePath.browserTabManagement,
              );

              _bloc.add(
                const BrowserPageOnInitEvent(),
              );
            },
            onSearchTap: () async {
              await AppNavigator.push(
                RoutePath.browserSearch,
              );

              _bloc.add(
                const BrowserPageOnInitEvent(),
              );
            },
            localization: localization,
          ),
        ),
        HoLiZonTalDividerWidget(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize06,
        ),
        Expanded(
          child: Padding(
            padding: defaultPadding(),
            child: Column(
              children: [
                BrowserPageTabSelector(
                  builder: (selectedTab) {
                    return BrowserPageTabWidget(
                      appTheme: appTheme,
                      localization: localization,
                      selectedTab: selectedTab,
                      onSelect: (index) {
                        _bloc.add(
                          BrowserPageOnChangeTabEvent(
                            index: index,
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: BoxSize.boxSize07,
                ),
                Expanded(
                  child: BrowserPageTabSelector(
                    builder: (selectedTab) {
                      return AnimatedCrossFade(
                        duration: const Duration(
                          milliseconds: 700,
                        ),
                        crossFadeState: selectedTab == 0
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: BrowserPageEcosystemsSelector(
                          builder: (ecosystems) {
                            return SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: CombinedListView(
                                onRefresh: () {
                                  //
                                },
                                onLoadMore: () {
                                  //
                                },
                                data: ecosystems,
                                builder: (browser, _) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Spacing.spacing06,
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await AppNavigator.push(
                                          RoutePath.browser,
                                          browser.url,
                                        );

                                        _bloc.add(
                                          const BrowserPageOnInitEvent(),
                                        );
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: BrowserPageSuggestionWidget(
                                        name: browser.name,
                                        description: browser.description ?? '',
                                        logo: browser.logo,
                                        appTheme: appTheme,
                                        suffix: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Spacing.spacing05,
                                            vertical: Spacing.spacing02,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              BorderRadiusSize
                                                  .borderRadiusRound,
                                            ),
                                            border: Border.all(
                                              color: appTheme.borderPrimary,
                                            ),
                                          ),
                                          child: Text(
                                            localization.translate(
                                              LanguageKey.browserPageOpen,
                                            ),
                                            style: AppTypoGraPhy.textSmMedium
                                                .copyWith(
                                              color: appTheme.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                canLoadMore: false,
                              ),
                            );
                          },
                        ),
                        secondChild: BrowserPageBookMarksSelector(
                          builder: (bookMark) {
                            if (bookMark.isEmpty) {
                              return Center(
                                child: Text(
                                  localization.translate(
                                    LanguageKey.browserNoBookMarkFound,
                                  ),
                                  style: AppTypoGraPhy.textSmMedium.copyWith(
                                    color: appTheme.textSecondary,
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: CombinedListView(
                                onRefresh: () {
                                  //
                                },
                                onLoadMore: () {
                                  //
                                },
                                data: bookMark,
                                builder: (bookMark, _) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Spacing.spacing06,
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await AppNavigator.push(
                                          RoutePath.browser,
                                          bookMark.url,
                                        );

                                        _bloc.add(
                                          const BrowserPageOnInitEvent(),
                                        );
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: BrowserPageSuggestionWidget(
                                        name: bookMark.name,
                                        description: bookMark.url,
                                        logo: bookMark.logo,
                                        appTheme: appTheme,
                                        suffix: BrowserPageBookMarkMoreActionWidget(
                                          appTheme: appTheme,
                                          onDelete: () {
                                            _bloc.add(
                                              BrowserPageOnDeleteBookMarkEvent(
                                                id: bookMark.id,
                                              ),
                                            );
                                          },
                                          localization: localization,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                canLoadMore: false,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
        body: child,
      ),
    );
  }
}

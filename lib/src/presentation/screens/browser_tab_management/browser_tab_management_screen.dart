import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/combined_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/browser_history_widget.dart';
import 'widgets/browser_tab_management_bottom_widget.dart';
import 'browser_tab_management_event.dart';
import 'browser_tab_management_state.dart';
import 'browser_tab_management_bloc.dart';
import 'browser_tab_management_selector.dart';

class BrowserTabManagementScreen extends StatefulWidget {
  final bool isCloseAndReplace;

  const BrowserTabManagementScreen({
    this.isCloseAndReplace = true,
    super.key,
  });

  @override
  State<BrowserTabManagementScreen> createState() =>
      _BrowserTabManagementScreenState();
}

class _BrowserTabManagementScreenState extends State<BrowserTabManagementScreen>
    with StateFulBaseScreen {
  final BrowserTabManagementBloc _bloc = getIt.get<BrowserTabManagementBloc>();

  void _backOrReplace(
    String url, {
    int? id,
  }) {
    if (widget.isCloseAndReplace) {
      AppNavigator.replaceWith(
        RoutePath.browser,
        url,
      );
    } else {
      AppNavigator.pop(
        _createBrowserResult(
          url,
          id: id,
        ),
      );
    }
  }

  Map<String, dynamic> _createBrowserResult(
    String url, {
    int? id,
  }) {
    return {
      'url': url,
      'id': id,
    };
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BrowserTabManagementStatusSelector(
      builder: (status) {
        switch (status) {
          case BrowserTabManagementStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case BrowserTabManagementStatus.loaded:
          case BrowserTabManagementStatus.closeAllSuccess:
          case BrowserTabManagementStatus.closeTabSuccess:
          case BrowserTabManagementStatus.addTabSuccess:
            return Column(
              children: [
                Expanded(
                  child: BrowserTabManagementBrowsersSelector(
                    builder: (browsers) {
                      if (browsers.isEmpty) {
                        return Center(
                          child: Text(
                            localization.translate(
                              LanguageKey.browserTabManagementScreenNoTabFound,
                            ),
                            style: AppTypoGraPhy.textSmMedium.copyWith(
                              color: appTheme.textSecondary,
                            ),
                          ),
                        );
                      }
                      return CombinedGridView(
                        childCount: 2,
                        onRefresh: () async {
                          //
                        },
                        onLoadMore: () {
                          //
                        },
                        data: browsers,
                        builder: (browser, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _backOrReplace(
                                browser.url,
                                id: browser.id,
                              );
                            },
                            child: BrowserTabManagementHistoryWidget(
                              appTheme: appTheme,
                              siteName: browser.siteTitle,
                              imageUri: browser.screenShotUri,
                              logo: browser.logo,
                              key: ValueKey(browser),
                              onClose: () {
                                _bloc.add(
                                  BrowserTabManagementOnCloseTabEvent(
                                    id: browser.id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        canLoadMore: false,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: Spacing.spacing06,
                        mainAxisSpacing: Spacing.spacing07,
                      );
                    },
                  ),
                ),
                BrowserTabManagementBottomWidget(
                  onAddNewTab: () {
                    _bloc.add(
                      const BrowserTabManagementOnAddNewTabEvent(),
                    );
                  },
                  onCloseAll: () {
                    _bloc.add(
                      const BrowserTabManagementOnClearEvent(),
                    );
                  },
                  appTheme: appTheme,
                  localization: localization,
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
      child: BlocListener<BrowserTabManagementBloc, BrowserTabManagementState>(
        listener: (context, state) {
          switch (state.status) {
            case BrowserTabManagementStatus.loading:
              break;
            case BrowserTabManagementStatus.loaded:
              break;
            case BrowserTabManagementStatus.closeTabSuccess:
              break;
            case BrowserTabManagementStatus.closeAllSuccess:
            case BrowserTabManagementStatus.addTabSuccess:
              _backOrReplace(
                AppLocalConstant.googleSearchUrl,
                id: state.activeBrowser?.id,
              );
              break;
          }
        },
        child: PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: appTheme.bgPrimary,
            body: child,
          ),
        ),
      ),
    );
  }
}

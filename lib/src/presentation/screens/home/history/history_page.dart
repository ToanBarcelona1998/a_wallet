import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/core/constants/aura_scan.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/helpers/app_launcher.dart';
import 'package:a_wallet/src/core/observer/history_page_observer.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_bloc.dart';
import 'history_event.dart';
import 'history_selector.dart';
import 'history_state.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

import 'widgets/transaction.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with StateFulBaseScreen {
  final AWalletConfig _config = getIt.get<AWalletConfig>();

  late HistoryBloc _bloc;

  final HistoryPageObserver _historyPageObserver =
      getIt.get<HistoryPageObserver>();

  void _addHistoryPageListener(HistoryPageEmitParam param) {
    final String event = param.event;
    final data = param.data;

    switch (event) {
      case HistoryPageObserver.onChangeAccount:
        _bloc.add(
          HistoryOnChangeAccountEvent(
            data,
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    _bloc = getIt.get<HistoryBloc>(
      param1: _config,
    );

    _bloc.add(
      const HistoryOnInitEvent(),
    );

    _historyPageObserver.addListener(_addHistoryPageListener);
    super.initState();
  }

  @override
  void dispose() {
    _historyPageObserver.removeListener(_addHistoryPageListener);
    super.dispose();
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return HistoryStatusSelector(
      builder: (status) {
        switch (status) {
          case HistoryStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case HistoryStatus.loaded:
          case HistoryStatus.loadMore:
          case HistoryStatus.error:
            return HistoryTransactionsSelector(
              builder: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      localization.translate(
                        LanguageKey.historyPageNoTxFound,
                      ),
                      style: AppTypoGraPhy.textSmMedium.copyWith(
                        color: appTheme.textSecondary,
                      ),
                    ),
                  );
                }
                return HistoryCanLoadMoreSelector(
                  builder: (canLoadMore) {
                    return CombinedListView(
                      onRefresh: () {
                        _bloc.add(
                          const HistoryOnRefreshEvent(),
                        );
                      },
                      onLoadMore: () {
                        _bloc.add(
                          const HistoryOnLoadMoreEvent(),
                        );
                      },
                      data: transactions,
                      builder: (tx, _) {
                        return HistoryFunctionMappingsSelector(
                          builder: (functions) {
                            String? data = tx.data;

                            String method = 'Send';

                            if (data != null) {
                              final String id = data.substring(0, 8);

                              final function = functions.firstWhereOrNull(
                                (f) => f.id == id,
                              );

                              method = _getMethodName(function);
                            }

                            return GestureDetector(
                              onTap: () {
                                AppLauncher.launch(
                                  AuraScan.transaction(
                                    tx.hash,
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: HistoryTransactionWidget(
                                hash: tx.hash,
                                createTime: tx.tx.time,
                                to: tx.to,
                                from: tx.from,
                                amount: TokenType.native.formatBalance(
                                  tx.value,
                                ),
                                functionName: method.toUpperCase(),
                                localization: localization,
                                appTheme: appTheme,
                              ),
                            );
                          },
                        );
                      },
                      canLoadMore: canLoadMore,
                    );
                  },
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
      value: _bloc,
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          localization: localization,
          isLeftActionActive: false,
          titleKey: LanguageKey.historyPageAppBarTitle,
        ),
        body: child,
      ),
    );
  }

  String _getMethodName(FunctionMapping? function) {
    String defaultMethod = 'Send';

    if (function != null) {
      RegExp regex = RegExp(r'function (\w+)\(');
      Match? match = regex.firstMatch(function.topic);
      return match?.group(1) ?? defaultMethod;
    }

    return defaultMethod;
  }
}

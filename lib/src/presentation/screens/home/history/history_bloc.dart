import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:domain/domain.dart';

import 'history_event.dart';
import 'history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final AccountUseCase _accountUseCase;
  final TransactionUseCase _transactionUseCase;
  final AWalletConfig config;

  HistoryBloc(
    this._accountUseCase,
    this._transactionUseCase, {
    required this.config,
  }) : super(
          const HistoryState(),
        ){
    on(_onInit);
    on(_onRefresh);
    on(_onLoadMore);
    on(_onChangeAccount);
  }

  Future<List<Transaction>> _getTransaction({
    Account? account,
    String? endTime,
    String? startTime,
  }) async {
    return _transactionUseCase.queryAccountTransaction(
      QueryTransactionRequest(
        address: (account?.evmAddress ?? state.activeAccount?.evmAddress ?? '').toLowerCase(),
        limit: state.limit,
        environment: config.environment.environmentString,
        endTime: endTime,
        startTime: startTime,
      ),
    );
  }

  List<String> _getFunctionIds(List<Transaction> transactions) {
    final List<String> ids = [];
    for (final tx in transactions) {
      if (tx.data != null) {
        String data = tx.data!;

        final String id = data.substring(0, 8);

        ids.add(id);
      }
    }
    return ids;
  }

  void _onInit(HistoryOnInitEvent event, Emitter<HistoryState> emit) async {
    emit(
      state.copyWith(
        status: HistoryStatus.loading,
        transactions: [],
        canLoadMore: false,
        functions: [],
      ),
    );
    try {
      final account = await _accountUseCase.getFirstAccount();

      emit(
        state.copyWith(
          activeAccount: account,
        ),
      );

      final transactions = await _getTransaction(
        account: account,
      );

      final List<String> functionIds = _getFunctionIds(transactions);

      final functionMappings = await _transactionUseCase.queryFunctionMapping(
        QueryFunctionMappingRequest(
          methodIds: functionIds,
          environment: config.environment.environmentString,
        ),
      );

      emit(
        state.copyWith(
          status: HistoryStatus.loaded,
          transactions: transactions,
          functions: functionMappings,
          canLoadMore: transactions.length == state.limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.error,
        ),
      );
      LogProvider.log('History bloc on init error ${e.toString()}');
    }
  }

  void _onRefresh(
    HistoryOnRefreshEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      state.copyWith(
        transactions: [],
      ),
    );

    try {
      final transactions = await _getTransaction();

      emit(
        state.copyWith(
          status: HistoryStatus.loaded,
          transactions: transactions,
          canLoadMore: transactions.length == state.limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.error,
        ),
      );
      LogProvider.log('History bloc on refresh error ${e.toString()}');
    }
  }

  void _onLoadMore(
    HistoryOnLoadMoreEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (state.status != HistoryStatus.loaded) return;

    emit(
      state.copyWith(
        status: HistoryStatus.loadMore,
      ),
    );

    try {
      final transactions = await _getTransaction(
        endTime: state.transactions.lastOrNull?.tx.time,
      );

      final List<String> functionIds = _getFunctionIds(transactions);

      final functionMappings = await _transactionUseCase.queryFunctionMapping(
        QueryFunctionMappingRequest(
          methodIds: functionIds,
          environment: config.environment.environmentString,
        ),
      );

      emit(
        state.copyWith(
          status: HistoryStatus.loaded,
          functions: [
            ...state.functions,
            ...functionMappings,
          ],
          transactions: [
            ...state.transactions,
            ...transactions,
          ],
          canLoadMore: transactions.length == state.limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HistoryStatus.error,
        ),
      );
      LogProvider.log('History bloc on load more error ${e.toString()}');
    }
  }

  void _onChangeAccount(
    HistoryOnChangeAccountEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      state.copyWith(
        activeAccount: event.account,
      ),
    );

    add(
      const HistoryOnInitEvent(),
    );
  }
}

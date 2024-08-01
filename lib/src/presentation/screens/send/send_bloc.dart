import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/helpers/address_validator.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';

import 'send_event.dart';
import 'send_state.dart';

final class SendBloc extends Bloc<SendEvent, SendState> {
  final TokenUseCase _tokenUseCase;
  final TokenMarketUseCase _tokenMarketUseCase;
  final BalanceUseCase _balanceUseCase;
  final AccountUseCase _accountUseCase;

  SendBloc(
    this._tokenUseCase,
    this._accountUseCase,
    this._balanceUseCase,
    this._tokenMarketUseCase,
  ) : super(
          const SendState(),
        ) {
    on(_onInit);
    on(_onChangeSaved);
    on(_onChangeAddress);
    on(_onChangeAmount);
    on(_onChangeToken);
  }

  void _onInit(SendOnInitEvent event, Emitter<SendState> emit) async {
    emit(
      state.copyWith(
        status: SendStatus.loading,
      ),
    );

    final List<Token> tokens = List.empty(growable: true);

    try {
      final account = await _accountUseCase.getFirstAccount();

      emit(
        state.copyWith(
          account: account,
          status: SendStatus.loaded,
        ),
      );

      final accountBalance = await _balanceUseCase.getByAccountID(
        accountId: account!.id,
      );

      Balance? selectedToken;

      if (accountBalance != null) {
        for (final balance in accountBalance.balances) {
          final token = await _tokenUseCase.get(balance.tokenId);

          if (token != null) {
            if (token.type == TokenType.native) {
              selectedToken = balance;
            }
            tokens.add(token);
          }
        }
      }

      emit(
        state.copyWith(
          status: SendStatus.loaded,
          accountBalance: accountBalance,
          selectedToken: selectedToken,
          tokens: tokens,
        ),
      );

      List<TokenMarket> tokenMarkets = await _tokenMarketUseCase.getAll();

      if (tokenMarkets.isEmpty) {
        tokenMarkets = await _tokenMarketUseCase.getRemoteTokenMarket();
      }

      emit(
        state.copyWith(
          status: SendStatus.loaded,
          tokenMarkets: tokenMarkets,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SendStatus.error,
        ),
      );
    }
  }

  void _onChangeSaved(SendOnChangeSavedEvent event, Emitter<SendState> emit) {
    emit(
      state.copyWith(
        isSaved: !state.isSaved,
        status: SendStatus.none,
      ),
    );
  }

  void _onChangeAddress(
    SendOnChangeToEvent event,
    Emitter<SendState> emit,
  ) {
    emit(
      state.copyWith(
        toAddress: event.address,
        already: _isReady(
          event.address,
          state.amountToSend,
          state.selectedToken,
        ),
        status: SendStatus.none,
      ),
    );
  }

  void _onChangeAmount(
    SendOnChangeAmountEvent event,
    Emitter<SendState> emit,
  ) {
    emit(
      state.copyWith(
        amountToSend: event.amount,
        already: _isReady(
          state.toAddress,
          event.amount,
          state.selectedToken,
        ),
        status: SendStatus.none,
      ),
    );
  }

  bool _isReady(String address, String amount, Balance? selectedToken) {
    try {
      if (selectedToken == null) return false;

      final token = state.tokens.firstWhereOrNull(
        (t) => t.id == selectedToken.tokenId,
      );

      double total = double.tryParse(token?.type.formatBalance(
                  selectedToken.balance ?? '',
                  customDecimal: token.decimal) ??
              '') ??
          0.0;
      // Parse the amount as a double
      double am = double.parse(amount);

      // Return true if amount is greater than 0 and less than or equal to the total balance
      return am > 0 &&
          am <= total &&
          addressInValid(
            address: address,
          );
    } catch (e) {
      // Return false if there's an exception (e.g., amount cannot be parsed as a double)
      return false;
    }
  }

  void _onChangeToken(
    SendOnChangeTokenEvent event,
    Emitter<SendState> emit,
  ) {
    emit(
      state.copyWith(
        selectedToken: event.token,
        already: _isReady(
          state.toAddress,
          state.amountToSend,
          event.token,
        ),
        status: SendStatus.reToken,
      ),
    );
  }
}

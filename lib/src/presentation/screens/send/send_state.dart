import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_state.freezed.dart';

enum SendStatus{
  none,
  loading,
  loaded,
  error,
  reNetwork,
  reToken,
}


@freezed
class SendState with _$SendState {
  const factory SendState({
    @Default(SendStatus.loading) SendStatus status,
    @Default(false) bool already,
    Account ?account,
    @Default([]) List<dynamic> addressBooks,
    AccountBalance ?accountBalance,
    Balance ?selectedToken,
    @Default([]) List<TokenMarket> tokenMarkets,
    @Default('') String toAddress,
    @Default('') String amountToSend,
    @Default(false) bool isSaved,
    @Default([]) List<Token> tokens,
    required List<AppNetwork> appNetworks,
    required AppNetwork selectedNetwork,
  }) = _SendState;
}

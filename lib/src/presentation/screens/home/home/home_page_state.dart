import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    Account? activeAccount,
    @Default([]) List<TokenMarket> tokenMarkets,
    AccountBalance ? accountBalance,
    @Default([]) List<NFTInformation> nftS,
    @Default(true) bool enableToken,
    @Default(0) double totalValue,
    @Default(0) double totalValueYesterday,
    @Default(0) double totalTokenValue,
    @Default(0) double estimateNFTValue,
    @Default([]) List<Token> tokens,
  }) = _HomePageState;
}

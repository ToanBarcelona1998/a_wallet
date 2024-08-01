import 'package:domain/core/core.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_event.freezed.dart';

@freezed
class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.getStorageData() = HomePageOnGetStorageDataEvent;

  const factory HomePageEvent.getRemoteData() = HomePageOnGetRemoteDataEvent;

  const factory HomePageEvent.updateTokenMarket({
    required List<TokenMarket> tokenMarkets,
  }) = HomePageOnUpdateTokenMarketEvent;

  const factory HomePageEvent.updateAccountBalance({
    required Map<TokenType, dynamic> balanceMap,
  }) = HomePageOnUpdateAccountBalanceEvent;

  const factory HomePageEvent.updateNFTs({
    required List<NFTInformation> nftS,
  }) = HomePageOnUpdateNFTsEvent;

  const factory HomePageEvent.changeEnable() =
      HomePageOnUpdateEnableTotalTokenEvent;

  const factory HomePageEvent.refreshTokenBalance({
    required TokenType tokenType,
  }) = HomePageOnRefreshTokenBalanceEvent;
}

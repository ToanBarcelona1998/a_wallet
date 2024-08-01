import 'package:domain/domain.dart';

extension PutAllTokenMarketRequestMapper on PutAllTokenMarketRequest {
  PutAllTokenMarketRequestDto get mapRequest => PutAllTokenMarketRequestDto(
        id: id,
        coinId: coinId,
        symbol: symbol,
        name: name,
        image: image,
        currentPrice: currentPrice,
        priceChangePercentage24h: priceChangePercentage24h,
        denom: denom,
        decimal: decimal,
      );
}

final class PutAllTokenMarketRequestDto {
  final int id;
  final String? coinId;
  final String symbol;
  final String? name;
  final String? image;
  final String currentPrice;
  final double priceChangePercentage24h;
  final String? denom;
  final int? decimal;

  const PutAllTokenMarketRequestDto({
    required this.id,
    this.coinId,
    required this.symbol,
    this.name,
    this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.denom,
    this.decimal,
  });
}

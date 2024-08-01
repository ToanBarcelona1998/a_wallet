import 'package:domain/domain.dart';

extension TokenMarketDtoMapper on TokenMarketDto {
  TokenMarket get toEntity => TokenMarket(
        id: id,
        coinId: coinId,
        symbol: symbol ?? '',
        name: name,
        image: image,
        currentPrice: currentPrice,
        priceChangePercentage24h: priceChangePercentage24h,
        denom: denom,
        decimal: decimal,
      );
}

class TokenMarketDto {
  final int id;
  final String ?coinId;
  final String ?symbol;
  final String ?name;
  final String? image;
  final String currentPrice;
  final double priceChangePercentage24h;
  final String? denom;
  final int? decimal;

  const TokenMarketDto({
    required this.id,
    this.coinId,
    this.symbol,
    this.name,
    this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.denom,
    this.decimal,
  });

  factory TokenMarketDto.fromJson(Map<String, dynamic> json) {
    return TokenMarketDto(
      id: json['id'],
      coinId: json['coinId'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['currentPrice'],
      priceChangePercentage24h: json['priceChangePercentage24h'].toDouble(),
      denom: json['denom'],
      decimal: json['decimal'],
    );
  }
}

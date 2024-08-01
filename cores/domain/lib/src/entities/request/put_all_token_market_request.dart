final class PutAllTokenMarketRequest {
  final int id;
  final String ?coinId;
  final String symbol;
  final String ?name;
  final String? image;
  final String currentPrice;
  final double priceChangePercentage24h;
  final String? denom;
  final int? decimal;

  const PutAllTokenMarketRequest({
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

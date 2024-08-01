import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'token_market_db.g.dart';

extension TokenMarketDtoRequestMapper on PutAllTokenMarketRequestDto {
  TokenMarketDb get mapRequestToDb => TokenMarketDb(
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

extension TokenMarketDbMapper on TokenMarketDb {
  TokenMarketDto get toDto => TokenMarketDto(
        id: id,
        currentPrice: currentPrice,
        priceChangePercentage24h: priceChangePercentage24h,
        decimal: decimal,
        name: name,
        symbol: symbol,
        denom: denom,
        image: image,
        coinId: coinId,
      );
}

@Collection(inheritance: false)
final class TokenMarketDb {
  final Id id;
  final String? coinId;
  final String? symbol;
  final String? name;
  final String? image;
  final String currentPrice;
  final double priceChangePercentage24h;
  final String? denom;
  final int? decimal;

  const TokenMarketDb({
    this.id = Isar.autoIncrement,
    this.coinId,
    this.symbol,
    this.name,
    this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.denom,
    this.decimal,
  });
}

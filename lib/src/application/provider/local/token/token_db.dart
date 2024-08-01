import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'token_db.g.dart';

extension AddTokenRequestDtoMapper on AddTokenRequestDto {
  TokenDb get toTokenDb => TokenDb(
        logo: logo,
        tokenName: tokenName,
        type: type.name,
        symbol: symbol,
        contractAddress: contractAddress,
        isEnable: isEnable,
        decimal: decimal,
      );
}

extension TokenDbExtension on TokenDb {
  TokenDb copyWith({
    String? name,
    String? logo,
    String? type,
    String? symbol,
    String? contract,
    bool? isEnable,
    int? decimal,
    int? id,
  }) {
    return TokenDb(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      tokenName: name ?? tokenName,
      type: type ?? this.type,
      symbol: symbol ?? this.symbol,
      contractAddress: contract ?? this.contractAddress,
      isEnable: isEnable ?? this.isEnable,
      decimal: decimal ?? this.decimal,
    );
  }

  TokenDto get toDto => TokenDto(
        id: id,
        logo: logo,
        tokenName: tokenName,
        type: type,
        symbol: symbol,
        contractAddress: contractAddress,
        isEnable: isEnable,
        decimal: decimal,
      );
}

@Collection(
  inheritance: false,
)
class TokenDb {
  final Id id;
  final String logo;
  final String tokenName;
  final String type;
  final bool isEnable;
  final String contractAddress;
  final int? decimal;
  final String symbol;

  TokenDb({
    this.id = Isar.autoIncrement,
    required this.logo,
    required this.tokenName,
    required this.type,
    required this.symbol,
    required this.contractAddress,
    required this.isEnable,
    this.decimal,
  });
}

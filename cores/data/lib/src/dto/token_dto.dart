import 'package:domain/domain.dart';

extension TokenDtoMapper on TokenDto {
  Token get toEntity => Token(
        id: id,
        logo: logo,
        tokenName: tokenName,
        type: tokenType,
        symbol: symbol,
        contractAddress: contractAddress,
        isEnable: isEnable,
        decimal: decimal,
      );
}

class TokenDto {
  final int id;
  final String logo;
  final String tokenName;
  final String type;
  final bool isEnable;
  final String contractAddress;
  final int? decimal;
  final String symbol;

  const TokenDto({
    required this.id,
    required this.logo,
    required this.tokenName,
    required this.type,
    required this.symbol,
    required this.contractAddress,
    required this.isEnable,
    this.decimal,
  });

  TokenType get tokenType {
    switch (type) {
      case 'erc20':
        return TokenType.erc20;
      default:
        return TokenType.native;
    }
  }
}

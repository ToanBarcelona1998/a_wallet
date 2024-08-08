import 'package:domain/core/core.dart';

final class Token {
  final int id;
  final String logo;
  final String tokenName;
  final TokenType type;
  final bool isEnable;
  final String contractAddress;
  final int? decimal;
  final String symbol;

  const Token({
    required this.id,
    required this.logo,
    required this.tokenName,
    required this.type,
    required this.symbol,
    required this.contractAddress,
    required this.isEnable,
    this.decimal,
  });
}

import 'package:domain/core/enum.dart';

final class AddTokenRequest {
  final String logo;
  final String tokenName;
  final TokenType type;
  final bool isEnable;
  final String contractAddress;
  final int? decimal;
  final String symbol;

  const AddTokenRequest({
    required this.logo,
    required this.tokenName,
    required this.type,
    required this.symbol,
    required this.contractAddress,
    required this.isEnable,
    this.decimal,
  });
}

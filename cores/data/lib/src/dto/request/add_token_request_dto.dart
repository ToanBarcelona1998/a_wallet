import 'package:domain/domain.dart';

extension AddTokenRequestMapper on AddTokenRequest {
  AddTokenRequestDto get mapRequest => AddTokenRequestDto(
        logo: logo,
        tokenName: tokenName,
        type: type,
        symbol: symbol,
        contractAddress: contractAddress,
        isEnable: isEnable,
        decimal: decimal,
      );
}

final class AddTokenRequestDto {
  final String logo;
  final String tokenName;
  final TokenType type;
  final bool isEnable;
  final String contractAddress;
  final int? decimal;
  final String symbol;

  const AddTokenRequestDto({
    required this.logo,
    required this.tokenName,
    required this.type,
    required this.symbol,
    required this.contractAddress,
    required this.isEnable,
    this.decimal,
  });
}

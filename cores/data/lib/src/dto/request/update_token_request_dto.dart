import 'package:domain/domain.dart';

extension UpdateTokenRequestMapper on UpdateTokenRequest {
  UpdateTokenRequestDto get mapRequest => UpdateTokenRequestDto(
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

final class UpdateTokenRequestDto {
  final int id;
  final String? logo;
  final String? tokenName;
  final TokenType? type;
  final bool? isEnable;
  final String? contractAddress;
  final int? decimal;
  final String? symbol;

  const UpdateTokenRequestDto({
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

import 'package:domain/core/enum.dart';

final class UpdateTokenRequest {
  final int id;
  final String ?logo;
  final String ?tokenName;
  final TokenType ?type;
  final bool ?isEnable;
  final String ?contractAddress;
  final int ?decimal;
  final String ?symbol;

  const UpdateTokenRequest({
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

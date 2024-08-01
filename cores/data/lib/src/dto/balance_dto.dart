import 'package:domain/domain.dart';

extension BalanceDtoMapper on BalanceDto {
  Balance get toEntity => Balance(
        balance: balance,
        tokenId: tokenId,
      );
}

extension AccountBalanceDtoMapper on AccountBalanceDto {
  AccountBalance get toEntity => AccountBalance(
        id: id,
        accountId: accountId,
        balances: balances
            .map(
              (e) => e.toEntity,
            )
            .toList(),
      );
}

extension ErcTokenBalanceDtoMapper on Erc20TokenBalanceDto {
  Erc20TokenBalance get toEntity => Erc20TokenBalance(
        amount: amount,
        denom: denom,
      );
}

class AccountBalanceDto {
  final int id;
  final int accountId;
  final List<BalanceDto> balances;

  const AccountBalanceDto({
    required this.id,
    required this.accountId,
    required this.balances,
  });
}

final class BalanceDto {
  final String balance;
  final int tokenId;

  const BalanceDto({
    required this.balance,
    required this.tokenId,
  });
}

// Remote fetch balance
final class Erc20TokenBalanceDto {
  final String denom;
  final String amount;

  const Erc20TokenBalanceDto({
    required this.amount,
    required this.denom,
  });

  factory Erc20TokenBalanceDto.fromJson(Map<String, dynamic> json) {
    return Erc20TokenBalanceDto(
      denom: json['denom'],
      amount: json['amount'],
    );
  }
}

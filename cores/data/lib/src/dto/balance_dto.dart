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

extension ErcTokenBalanceDtoMapper on ErcTokenBalanceDto {
  ErcTokenBalance get toEntity => ErcTokenBalance(
        amount: amount,
        denom: denom,
      );
}

extension Cw20TokenBalanceDtoMapper on Cw20TokenBalanceDto {
  Cw20TokenBalance get toEntity => Cw20TokenBalance(
        amount: amount,
        contract: contract.toEntity,
      );
}

extension Cw20TokenContractDtoMapper on Cw20TokenContractDto {
  Cw20TokenContract get toEntity => Cw20TokenContract(
        name: name,
        symbol: symbol,
        decimal: decimal,
        smartContract: smartContract.toEntity,
      );
}

extension Cw20TokenSmartContractDtoMapper on Cw20TokenSmartContractDto {
  Cw20TokenSmartContract get toEntity => Cw20TokenSmartContract(
        address: address,
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

class BalanceDto {
  final String balance;
  final int tokenId;

  const BalanceDto({
    required this.balance,
    required this.tokenId,
  });
}

// Remote fetch balance
final class ErcTokenBalanceDto {
  final String denom;
  final String amount;

  const ErcTokenBalanceDto({
    required this.amount,
    required this.denom,
  });

  factory ErcTokenBalanceDto.fromJson(Map<String, dynamic> json) {
    return ErcTokenBalanceDto(
      denom: json['denom'],
      amount: json['amount'],
    );
  }
}

final class Cw20TokenBalanceDto {
  final String amount;
  final Cw20TokenContractDto contract;

  const Cw20TokenBalanceDto({
    required this.amount,
    required this.contract,
  });

  factory Cw20TokenBalanceDto.fromJson(Map<String, dynamic> json) {
    return Cw20TokenBalanceDto(
      amount: json['amount'],
      contract: Cw20TokenContractDto.fromJson(
        json['cw20_contract'],
      ),
    );
  }
}

final class Cw20TokenContractDto {
  final String name;
  final String symbol;
  final String? decimal;
  final Cw20TokenSmartContractDto smartContract;

  const Cw20TokenContractDto({
    required this.name,
    required this.symbol,
    this.decimal,
    required this.smartContract,
  });

  factory Cw20TokenContractDto.fromJson(Map<String, dynamic> json) {
    return Cw20TokenContractDto(
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      decimal: json['decimal'],
      smartContract: Cw20TokenSmartContractDto.fromJson(
        json['smart_contract'],
      ),
    );
  }
}

final class Cw20TokenSmartContractDto {
  final String address;

  const Cw20TokenSmartContractDto({
    required this.address,
  });

  factory Cw20TokenSmartContractDto.fromJson(Map<String, dynamic> json) {
    return Cw20TokenSmartContractDto(
      address: json['address'] ?? '',
    );
  }
}

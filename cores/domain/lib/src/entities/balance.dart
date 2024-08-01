final class AccountBalance {
  final int id;
  final int accountId;
  final List<Balance> balances;

  const AccountBalance({
    required this.id,
    required this.accountId,
    required this.balances,
  });
}

final class Balance {
  final String balance;
  final int tokenId;

  const Balance({
    required this.balance,
    required this.tokenId,
  });
}

// Remote fetch balance
final class ErcTokenBalance {
  final String denom;
  final String amount;

  const ErcTokenBalance({
    required this.amount,
    required this.denom,
  });
}

final class Cw20TokenBalance {
  final String amount;
  final Cw20TokenContract contract;

  const Cw20TokenBalance({
    required this.amount,
    required this.contract,
  });
}

final class Cw20TokenContract {
  final String name;
  final String symbol;
  final String? decimal;
  final Cw20TokenSmartContract smartContract;

  const Cw20TokenContract({
    required this.name,
    required this.symbol,
    this.decimal,
    required this.smartContract,
  });
}

final class Cw20TokenSmartContract {
  final String address;

  const Cw20TokenSmartContract({
    required this.address,
  });
}

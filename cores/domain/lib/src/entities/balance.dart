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
final class Erc20TokenBalance {
  final String denom;
  final String amount;

  const Erc20TokenBalance({
    required this.amount,
    required this.denom,
  });
}

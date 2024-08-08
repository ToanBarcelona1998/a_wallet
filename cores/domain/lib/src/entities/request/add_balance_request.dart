
final class AddAccountBalanceRequest {
  final int accountId;
  final List<AddBalanceRequest> balances;

  const AddAccountBalanceRequest({
    required this.accountId,
    required this.balances,
  });
}

final class AddBalanceRequest {
  final String balance;
  final int tokenId;

  const AddBalanceRequest({
    required this.balance,
    required this.tokenId,
  });
}

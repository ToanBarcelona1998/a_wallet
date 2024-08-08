abstract class QueryBalanceRequest {
  final String address;
  final String environment;

  const QueryBalanceRequest({
    required this.address,
    required this.environment,
  });
}

final class QueryERC20BalanceRequest extends QueryBalanceRequest {
  QueryERC20BalanceRequest({
    required super.address,
    required super.environment,
  });
}

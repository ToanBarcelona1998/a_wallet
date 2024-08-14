final class QueryTransactionRequest {
  final String address;
  final int limit;
  final String? startTime;
  final String? endTime;
  final String environment;

  const QueryTransactionRequest({
    required this.address,
    required this.limit,
    required this.environment,
    this.startTime,
    this.endTime,
  });
}

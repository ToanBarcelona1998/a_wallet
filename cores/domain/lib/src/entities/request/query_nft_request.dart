abstract class QueryNftRequest {
  final int offset;
  final int limit;
  final String? contractAddress;
  final String owner;
  final String environment;

  const QueryNftRequest({
    this.offset = 0,
    this.limit = 10,
    required this.owner,
    required this.environment,
    this.contractAddress,
  });
}

final class QueryCW721Request extends QueryNftRequest {
  const QueryCW721Request({
    required super.owner,
    required super.environment,
    super.contractAddress,
    super.limit,
    super.offset,
  });
}

final class QueryERC721Request extends QueryNftRequest {
  const QueryERC721Request({
    required super.owner,
    required super.environment,
    super.contractAddress,
    super.limit,
    super.offset,
  });
}

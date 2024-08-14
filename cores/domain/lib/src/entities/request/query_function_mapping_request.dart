final class QueryFunctionMappingRequest {
  final List<String> methodIds;
  final String environment;

  const QueryFunctionMappingRequest({
    required this.methodIds,
    required this.environment,
  });
}

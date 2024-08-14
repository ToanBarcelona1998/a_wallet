import 'package:domain/domain.dart';

import 'graphql_request_dto.dart';

extension QueryFunctionMappingRequestMapper on QueryFunctionMappingRequest {
  QueryFunctionMappingRequestDto get mapRequest =>
      QueryFunctionMappingRequestDto(
        methodIds: methodIds,
        environment: environment,
      );
}

final class QueryFunctionMappingRequestDto extends GraphqlRequestDto {
  final List<String> methodIds;
  final String environment;

  const QueryFunctionMappingRequestDto({
    required this.methodIds,
    required this.environment,
  });

  @override
  String operationName() {
    return 'queryListNameMethod';
  }

  @override
  String query() {
    const String query =  r'''
    query queryListNameMethod($limit: Int = 100, $methodId: [String!] = null) {
      ${environment} {
        evm_signature_mapping(where: {function_id: {_in: $methodId}}) {
          function_id
          human_readable_topic
        }
      }
    }
    ''';

    return query.replaceAll('\${environment}', environment);
  }

  @override
  Map<String, dynamic> variables() {
    return {
      'methodId' : methodIds,
    };
  }
}

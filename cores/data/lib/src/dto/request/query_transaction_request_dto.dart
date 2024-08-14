import 'package:domain/domain.dart';

import 'graphql_request_dto.dart';

extension QueryTransactionRequestMapper on QueryTransactionRequest {
  QueryTransactionRequestDto get mapRequest => QueryTransactionRequestDto(
        address: address,
        limit: limit,
        environment: environment,
        endTime: endTime,
        startTime: startTime,
      );
}

final class QueryTransactionRequestDto extends GraphqlRequestDto {
  final String address;
  final int limit;
  final String? startTime;
  final String? endTime;
  final String environment;

  const QueryTransactionRequestDto({
    required this.address,
    required this.limit,
    required this.environment,
    this.startTime,
    this.endTime,
  });

  @override
  String operationName() {
    return 'QueryEvmTxOfAccount';
  }

  @override
  String query() {
    const String query = r'''
    query QueryEvmTxOfAccount($startTime: timestamptz = null, $endTime: timestamptz = null, $limit: Int = null, $orderId: order_by = desc, $address: String! = null) {
      ${environment} {
        evm_transaction(where: {from: {_eq: $address}, transaction: {timestamp: {_gt: $startTime, _lt: $endTime}}}, limit: $limit, order_by: {id: $orderId}) {
          data
          from
          to
          hash
          height
          value
          erc20_activities {
            amount
          }
          transaction {
            timestamp
            hash
          }
        }
      }
    } 
    ''';

    return query.replaceAll('\${environment}', environment);
  }

  @override
  Map<String, dynamic> variables() {
    return {
      'address': address,
      'endTime': endTime,
      'limit': limit,
      'startTime': startTime,
    };
  }
}

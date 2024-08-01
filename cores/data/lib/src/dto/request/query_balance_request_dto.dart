import 'package:domain/domain.dart';

import 'graphql_request_dto.dart';

extension QueryERC20BalanceRequestMapper on QueryERC20BalanceRequest {
  QueryERC20BalanceRequestDto get mapRequest => QueryERC20BalanceRequestDto(
        address: address,
        environment: environment,
      );
}

abstract class QueryBalanceRequestDto extends GraphqlRequestDto {
  final String address;
  final String environment;

  const QueryBalanceRequestDto({
    required this.address,
    required this.environment,
  });

  @override
  Map<String, dynamic> variables() {
    return {
      'address': address,
    };
  }
}

final class QueryERC20BalanceRequestDto extends QueryBalanceRequestDto {
  QueryERC20BalanceRequestDto({
    required super.address,
    required super.environment,
  });

  @override
  String operationName() {
    return 'ERC20_TOKENS_TEMPLATE';
  }

  @override
  String query() {
    const String query = r'''
    query ERC20_TOKENS_TEMPLATE($address: String = "") {
    ${environment}  {
      account_balance(where: {account: {address: {_eq: $address}}, denom: {_ilike: "%0x%"}}) {
        denom
        amount
      }
    }
  }
    ''';

    return query.replaceAll('\${environment}', environment);
  }
}
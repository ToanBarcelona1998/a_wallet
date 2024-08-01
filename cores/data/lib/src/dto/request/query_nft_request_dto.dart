import 'package:domain/domain.dart';

import 'graphql_request_dto.dart';

extension QueryNftRequestMapper on QueryNftRequest {
  QueryNftRequestDto get mapRequest {
    if (this is QueryCW721Request) {
      return QueryCW721RequestDto(
        owner: owner,
        environment: environment,
        offset: offset,
        contractAddress: contractAddress,
        limit: limit,
      );
    }

    return QueryERC721RequestDto(
      owner: owner,
      environment: environment,
      offset: offset,
      contractAddress: contractAddress,
      limit: limit,
    );
  }
}

abstract class QueryNftRequestDto extends GraphqlRequestDto {
  final int offset;
  final int limit;
  final String? contractAddress;
  final String owner;
  final String environment;

  const QueryNftRequestDto({
    this.offset = 0,
    this.limit = 10,
    required this.owner,
    required this.environment,
    this.contractAddress,
  });

  @override
  Map<String, dynamic> variables() {
    return {
      'contract_address': contractAddress,
      'limit': limit,
      'offset': offset,
      'owner': owner,
    };
  }
}

final class QueryCW721RequestDto extends QueryNftRequestDto {
  const QueryCW721RequestDto({
    required super.owner,
    required super.environment,
    super.contractAddress,
    super.limit,
    super.offset,
  });

  @override
  String operationName() {
    return 'queryAssetCW721';
  }

  @override
  String query() {
    const query = r'''
    query queryAssetCW721(
      $contract_address: String
      $limit: Int = 10
      $tokenId: String = null
      $owner: String = null
      $offset: Int = 0
    ) {
      euphoria {
        cw721_token(
          limit: $limit
          offset: $offset
          where: {
            cw721_contract: {
              smart_contract: { address: { _eq: $contract_address }, name: {_neq: "crates.io:cw4973"} }
            }
            token_id: { _eq: $tokenId }
            owner: { _eq: $owner }
            burned: {_eq: false}
          }
          order_by: [{ last_updated_height: desc }, { id: desc }]
        ) {
          id
          token_id
          owner
          media_info
          last_updated_height
          created_at
          burned
          cw721_contract {
            name
            symbol
            smart_contract {
              name
              address
            }
          }
        }
      }
    }
    
    ''';

    return query.replaceAll('\${environment}', environment);
  }
}

final class QueryERC721RequestDto extends QueryNftRequestDto {
  const QueryERC721RequestDto({
    required super.owner,
    required super.environment,
    super.contractAddress,
    super.limit,
    super.offset,
  });

  @override
  String operationName() {
    return 'queryAssetERC721';
  }

  @override
  String query() {
    const query = r'''
    query queryAssetERC721($contract_address: String, $limit: Int = 10, $tokenId: String = null, $owner: String = null, $offset: Int = 0) {
  ${environment} {
    cw721_token: erc721_token(
      limit: $limit
      offset: $offset
      where: {erc721_contract: {evm_smart_contract: {address: {_eq: $contract_address}}}, token_id: {_eq: $tokenId}, owner: {_eq: $owner}}
      order_by: [{last_updated_height: desc}, {id: desc}]
    ) {
      id
      token_id
      owner
      media_info
      last_updated_height
      created_at
      cw721_contract: erc721_contract {
        name
        symbol
        smart_contract: evm_smart_contract {
          address
        }
      }
    }
  }
}
    ''';

    return query.replaceAll('\${environment}', environment);
  }
}

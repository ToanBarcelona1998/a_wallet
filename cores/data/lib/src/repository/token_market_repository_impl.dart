import 'package:data/src/dto/request/put_all_token_market_request_dto.dart';
import 'package:data/src/dto/token_market.dto.dart';
import 'package:data/src/resource/local/token_market_database_service.dart';
import 'package:data/src/resource/remote/token_market_service.dart';
import 'package:domain/domain.dart';

final class TokenMarketRepositoryImpl implements TokenMarketRepository {
  final TokenMarketDatabaseService _marketDatabaseService;
  final RemoteTokenMarketService _remoteTokenMarketService;

  const TokenMarketRepositoryImpl(
    this._remoteTokenMarketService,
    this._marketDatabaseService,
  );

  @override
  Future<TokenMarket> add<P>(P param) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) {
    return _marketDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _marketDatabaseService.deleteAll();
  }

  @override
  Future<TokenMarket?> get(int id) async {
    final tokenMarketDto = await _marketDatabaseService.get(id);

    return tokenMarketDto?.toEntity;
  }

  @override
  Future<List<TokenMarket>> getAll() async {
    final List<TokenMarketDto> tokenMarkets =
        await _marketDatabaseService.getAll();

    return tokenMarkets
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }

  @override
  Future<List<TokenMarket>> getRemoteTokenMarket() async {
    final response = await _remoteTokenMarketService.getRemoteTokenMarket();

    final List<TokenMarketDto> tokenMarketsDto = [];

    for (final map in response) {
      final TokenMarketDto tokenMarketDto = TokenMarketDto.fromJson(map);

      tokenMarketsDto.add(tokenMarketDto);
    }

    return tokenMarketsDto
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }

  @override
  Future<void> putAll({required List<PutAllTokenMarketRequest> request}) {
    return _marketDatabaseService.putAll(
      param: request
          .map(
            (e) => e.mapRequest,
          )
          .toList(),
    );
  }

  @override
  Future<TokenMarket> update<P>(P param) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

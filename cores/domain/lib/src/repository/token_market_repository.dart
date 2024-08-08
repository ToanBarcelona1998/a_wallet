import 'package:domain/src/entities/request/put_all_token_market_request.dart';
import 'package:domain/src/entities/token_market.dart';
import 'package:domain/src/repository/local_database_repository.dart';

abstract class LocalTokenMarketRepository
    extends LocalDatabaseRepository<TokenMarket> {
  Future<void> putAll({
    required List<PutAllTokenMarketRequest> request,
  });
}

abstract class RemoteTokenMarketRepository {
  Future<List<TokenMarket>> getRemoteTokenMarket();
}

abstract interface class TokenMarketRepository
    implements LocalTokenMarketRepository , RemoteTokenMarketRepository {

}

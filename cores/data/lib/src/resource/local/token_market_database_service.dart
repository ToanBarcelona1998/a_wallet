import 'package:data/src/dto/request/put_all_token_market_request_dto.dart';
import 'package:data/src/dto/token_market.dto.dart';
import 'local_database_service.dart';

abstract interface class TokenMarketDatabaseService extends LocalDatabaseService<TokenMarketDto>{
  Future<void> putAll({required List<PutAllTokenMarketRequestDto> param});
}
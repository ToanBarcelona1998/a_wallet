import 'package:domain/src/entities/entities.dart';
import 'package:domain/src/repository/token_market_repository.dart';

final class TokenMarketUseCase {
  final TokenMarketRepository _tokenMarketRepository;

  const TokenMarketUseCase(this._tokenMarketRepository);

  Future<void> delete(int id) {
    return _tokenMarketRepository.delete(id);
  }

  Future<void> deleteAll() {
    return _tokenMarketRepository.deleteAll();
  }

  Future<TokenMarket?> get(int id) async {
    return _tokenMarketRepository.get(id);
  }

  Future<List<TokenMarket>> getAll() async {
    return _tokenMarketRepository.getAll();
  }

  Future<List<TokenMarket>> getRemoteTokenMarket() async {
    return _tokenMarketRepository.getRemoteTokenMarket();
  }

  Future<void> putAll({
    required List<PutAllTokenMarketRequest> request,
  }) {
    return _tokenMarketRepository.putAll(request: request);
  }
}

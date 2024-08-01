import 'package:domain/src/entities/request/add_token_request.dart';
import 'package:domain/src/entities/token.dart';
import 'package:domain/src/repository/token_repository.dart';

final class TokenUseCase {
  final TokenRepository _tokenRepository;

  const TokenUseCase(this._tokenRepository);

  Future<Token> add(AddTokenRequest param) {
    return _tokenRepository.add(param);
  }

  Future<void> delete(int id) {
    return _tokenRepository.delete(id);
  }

  Future<Token?> get(int id) {
    return _tokenRepository.get(id);
  }

  Future<List<Token>> getAll() {
    return _tokenRepository.getAll();
  }

  Future<void> deleteAll() {
    return _tokenRepository.deleteAll();
  }

  Future<Token?> getByName({
    required String name,
  }) {
    return _tokenRepository.getByName(name: name);
  }
}

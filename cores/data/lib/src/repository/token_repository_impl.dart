import 'package:data/src/dto/request/add_token_request_dto.dart';
import 'package:data/src/dto/token_dto.dart';
import 'package:data/src/resource/local/token_database_service.dart';
import 'package:domain/domain.dart';

final class TokenRepositoryImpl implements TokenRepository{
  final TokenDatabaseService _tokenDatabaseService;

  const TokenRepositoryImpl(this._tokenDatabaseService);

  @override
  Future<Token> add<P>(P param) async{
    final tokenDto = await _tokenDatabaseService.add((param as AddTokenRequest).mapRequest);

    return tokenDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _tokenDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _tokenDatabaseService.deleteAll();
  }

  @override
  Future<Token?> get(int id) async{
    final tokenDto = await _tokenDatabaseService.get(id);

    return tokenDto?.toEntity;
  }

  @override
  Future<List<Token>> getAll() async{
    final tokensDto = await _tokenDatabaseService.getAll();

    return tokensDto.map((e) => e.toEntity,).toList();
  }

  @override
  Future<Token> update<P>(P param) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Token?> getByName({
    required String name,
  }) async{
    final tokenDto = await _tokenDatabaseService.getByName(name: name);

    return tokenDto?.toEntity;
  }

}
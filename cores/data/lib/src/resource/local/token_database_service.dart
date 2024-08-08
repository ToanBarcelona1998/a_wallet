import 'package:data/src/dto/token_dto.dart';

import 'local_database_service.dart';

abstract interface class TokenDatabaseService implements LocalDatabaseService<TokenDto>{
  Future<TokenDto?> getByName({
    required String name,
  });
}
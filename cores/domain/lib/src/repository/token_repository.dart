import 'package:domain/src/entities/token.dart';
import 'local_database_repository.dart';

abstract interface class TokenRepository
    implements LocalDatabaseRepository<Token> {
  Future<Token?> getByName({
    required String name,
  });
}

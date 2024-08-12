import 'package:data/src/dto/account_dto.dart';

import 'local_database_service.dart';

abstract interface class AccountDatabaseService extends LocalDatabaseService<AccountDto>{
  Future<List<AccountDto>> queryByAddress({
    required String address,
  });

  Future<AccountDto?> getFirstAccount();

  Future<AccountDto> updateChangeIndex({
    required int id,
  });
}
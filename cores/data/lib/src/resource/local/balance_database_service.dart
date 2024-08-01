import 'package:data/data.dart';

abstract interface class BalanceDatabaseService
    extends LocalDatabaseService<AccountBalanceDto> {
  Future<AccountBalanceDto?> getByAccountID({
    required int accountId,
  });
}

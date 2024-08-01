import 'package:domain/src/entities/balance.dart';
import 'package:domain/src/entities/request/query_balance_request.dart';
import 'package:domain/src/repository/local_database_repository.dart';

abstract class RemoteBalanceRepository {
  Future<String> getNativeBalance({
    required String address,
  });

  Future<List<ErcTokenBalance>> getErc20Balance(
    QueryBalanceRequest request,
  );

  Future<List<Cw20TokenBalance>> getCw20Balance(
    QueryBalanceRequest request,
  );
}

abstract class LocalBalanceRepository
    extends LocalDatabaseRepository<AccountBalance> {
  Future<AccountBalance?> getByAccountID({
    required int accountId,
  });
}

abstract interface class BalanceRepository
    implements RemoteBalanceRepository, LocalBalanceRepository {}

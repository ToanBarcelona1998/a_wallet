import 'package:data/data.dart';
import 'package:isar/isar.dart';
import 'balance_db.dart';

final class BalanceDatabaseServiceImpl implements BalanceDatabaseService {
  final Isar _database;

  const BalanceDatabaseServiceImpl(this._database);

  @override
  Future<AccountBalanceDto> add<P>(P param) async {
    AccountBalanceDb balanceDb =
        (param as AddAccountBalanceRequestDto).mapRequestToDb;
    await _database.writeTxn(
      () async {
        final int id = await _database.accountBalanceDbs.put(
          balanceDb,
        );

        balanceDb = balanceDb.copyWith(
          id: id,
        );
      },
    );

    return balanceDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.accountBalanceDbs.delete(id);
      },
    );
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(
      () async {
        await _database.accountBalanceDbs.where().deleteAll();
      },
    );
  }

  @override
  Future<AccountBalanceDto?> get(int id) async{
    final aDb = await _database.accountBalanceDbs.get(id);

    return aDb?.toDto;
  }

  @override
  Future<List<AccountBalanceDto>> getAll() async{
    final aBalanceDb = await  _database.accountBalanceDbs.where().findAll();

    return aBalanceDb.map((e) => e.toDto,).toList();
  }

  @override
  Future<AccountBalanceDto> update<P>(P param) async {
    throw UnimplementedError();
  }

  @override
  Future<AccountBalanceDto?> getByAccountID({required int accountId}) async{
    final aDb = await _database.accountBalanceDbs
        .filter()
        .accountIdEqualTo(accountId)
        .findFirst();

    return aDb?.toDto;
  }
}

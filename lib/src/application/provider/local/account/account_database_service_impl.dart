import 'package:data/data.dart';
import 'package:isar/isar.dart';

import 'account_db.dart';

final class AccountDatabaseServiceImpl implements AccountDatabaseService {
  final Isar _database;

  const AccountDatabaseServiceImpl(this._database);

  @override
  Future<AccountDto> add<P>(P param) async {
    final AddAccountRequestDto p = param as AddAccountRequestDto;
    AccountDb accountDb = p.mapRequestToDb;

    await _database.writeTxn(
      () async {
        final id = await _database.accountDbs.put(accountDb);

        accountDb = accountDb.copyWith(
          id: id,
        );
      },
    );

    return accountDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.accountDbs.delete(id);
      },
    );
  }

  @override
  Future<AccountDto?> get(int id) async{
    final aDb = await _database.accountDbs.get(id);

    return aDb?.toDto;
  }

  @override
  Future<List<AccountDto>> getAll() async{
    final aDbs = await _database.accountDbs.where().findAll();

    return aDbs.map((e) => e.toDto,).toList();
  }

  @override
  Future<List<AccountDto>> queryByAddress({
    required String address,
  }) {
    // TODO: implement queryByAddress
    throw UnimplementedError();
  }

  @override
  Future<AccountDto> update<P>(P param) async {
    final UpdateAccountRequestDto p = param as UpdateAccountRequestDto;
    AccountDb? accountDb = await _database.accountDbs.get(
      p.id,
    );

    if (accountDb != null) {
      accountDb = accountDb.copyWith(
        name: p.name,
        keyStoreId: p.keyStoreId,
        index: p.index,
        aEvmInfoDb: p.updateAEvmInfoRequest?.mapRequestToDb,
        aCosmosInfoDb: p.updateACosmosInfoRequest?.mapRequestToDb,
      );

      await _database.writeTxn(
        () async {
          await _database.accountDbs.put(accountDb!);
        },
      );

      return accountDb.toDto;
    }

    throw Exception('Account is not found');
  }

  @override
  Future<AccountDto?> getFirstAccount() async{
    final aDb = await _database.accountDbs.filter().indexEqualTo(0).findFirst();

    return aDb?.toDto;
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(() async{
      await _database.accountDbs.where().deleteAll();
    },);
  }

  @override
  Future<void> updateChangeIndex({
    required int id,
  }) async {
    AccountDb? account = await _database.accountDbs.get(id);

    final AccountDb? currentAccount =
    await _database.accountDbs.filter().indexEqualTo(0).findFirst();

    if (account == null || currentAccount == null) return;

    await _database.writeTxn(() async {
      await _database.accountDbs.put(
        currentAccount.copyWith(
          index: 1,
        ),
      );
      await _database.accountDbs.put(
        account.copyWith(
          index: 0,
        ),
      );
    });
  }
}

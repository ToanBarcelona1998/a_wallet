import 'package:data/src/dto/account_dto.dart';
import 'package:data/src/dto/request/add_account_request_dto.dart';
import 'package:data/src/dto/request/update_account_request_dto.dart';
import 'package:data/src/resource/local/account_database_service.dart';
import 'package:domain/domain.dart';

final class AccountRepositoryImpl implements AccountRepository {
  final AccountDatabaseService _accountDatabaseService;

  const AccountRepositoryImpl(this._accountDatabaseService);

  @override
  Future<Account> add<P>(P param) async {
    final accountDto = await _accountDatabaseService.add(
      (param as AddAccountRequest).mapRequest,
    );

    return accountDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _accountDatabaseService.delete(id);
  }

  @override
  Future<Account?> get(int id) async {
    final accountDto = await _accountDatabaseService.get(id);

    return accountDto?.toEntity;
  }

  @override
  Future<List<Account>> getAll() async {
    final accountsDto = await _accountDatabaseService.getAll();

    return accountsDto.map((e) => e.toEntity).toList();
  }

  @override
  Future<List<Account>> queryByAddress({required String address}) {
    // TODO: implement queryByAddress
    throw UnimplementedError();
  }

  @override
  Future<Account> update<P>(P param) async {
    final accountDto = await _accountDatabaseService.update(
      (param as UpdateAccountRequest).mapRequest,
    );

    return accountDto.toEntity;
  }

  @override
  Future<Account?> getFirstAccount() async{
    final accountDto = await _accountDatabaseService.getFirstAccount();

    return accountDto?.toEntity;
  }

  @override
  Future<void> deleteAll() {
    return _accountDatabaseService.deleteAll();
  }

  @override
  Future<void> updateChangeIndex({required int id}) {
    return _accountDatabaseService.updateChangeIndex(id: id);
  }
}

import 'package:domain/src/entities/account.dart';
import 'package:domain/src/entities/request/add_account_request.dart';
import 'package:domain/src/entities/request/update_account_request.dart';
import 'package:domain/src/repository/account_repository.dart';

final class AccountUseCase {
  final AccountRepository _accountRepository;

  const AccountUseCase(this._accountRepository);

  Future<Account> add(AddAccountRequest param) {
    return _accountRepository.add<AddAccountRequest>(param);
  }

  Future<void> delete(int id) {
    return _accountRepository.delete(id);
  }

  Future<Account?> get(int id) {
    return _accountRepository.get(id);
  }

  Future<List<Account>> getAll() async {
    return _accountRepository.getAll();
  }

  Future<List<Account>> queryByAddress({required String address}) {
    return _accountRepository.queryByAddress(
      address: address,
    );
  }

  Future<Account> update(UpdateAccountRequest param) async {
    return _accountRepository.update<UpdateAccountRequest>(param);
  }

  Future<Account?> getFirstAccount(){
    return _accountRepository.getFirstAccount();
  }

  Future<void> deleteAll(){
    return _accountRepository.deleteAll();
  }

  Future<void> updateChangeIndex({
    required int id,
  }){
    return _accountRepository.updateChangeIndex(id: id);
  }
}

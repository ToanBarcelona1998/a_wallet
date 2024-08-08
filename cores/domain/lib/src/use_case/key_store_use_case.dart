import 'package:domain/src/entities/key_store.dart';
import 'package:domain/src/entities/request/add_key_store_request.dart';
import 'package:domain/src/repository/key_store_repository.dart';

import 'package:domain/src/entities/request/update_key_store_request.dart';

final class KeyStoreUseCase {
  final KeyStoreRepository _keyStoreRepository;

  const KeyStoreUseCase(this._keyStoreRepository);

  Future<KeyStore> add(AddKeyStoreRequest param) {
    return _keyStoreRepository.add<AddKeyStoreRequest>(param);
  }

  Future<void> delete(int id) {
    return _keyStoreRepository.delete(id);
  }

  Future<KeyStore?> get(int id) {
    return _keyStoreRepository.get(id);
  }

  Future<List<KeyStore>> getAll() async {
    return _keyStoreRepository.getAll();
  }

  Future<KeyStore> update(UpdateKeyStoreRequest param) async {
    return _keyStoreRepository.update<UpdateKeyStoreRequest>(param);
  }

  Future<void> deleteAll(){
    return _keyStoreRepository.deleteAll();
  }
}
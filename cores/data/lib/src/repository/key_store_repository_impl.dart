import 'package:data/src/dto/key_store_dto.dart';
import 'package:data/src/dto/request/add_key_store_request_dto.dart';
import 'package:data/src/dto/request/update_key_store_request_dto.dart';
import 'package:data/src/resource/local/key_store_database_service.dart';
import 'package:domain/domain.dart';

final class KeyStoreRepositoryImpl implements KeyStoreRepository {
  final KeyStoreDatabaseService _keyStoreDatabaseService;

  const KeyStoreRepositoryImpl(this._keyStoreDatabaseService);

  @override
  Future<KeyStore> add<P>(P param) async {
    final keyStoreDto = await _keyStoreDatabaseService.add(
      (param as AddKeyStoreRequest).mapRequest,
    );

    return keyStoreDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _keyStoreDatabaseService.delete(id);
  }

  @override
  Future<KeyStore?> get(int id) async {
    final keyStoreDto = await _keyStoreDatabaseService.get(id);

    return keyStoreDto?.toEntity;
  }

  @override
  Future<List<KeyStore>> getAll() async {
    final keyStoresDto = await _keyStoreDatabaseService.getAll();

    return keyStoresDto.map((e) => e.toEntity).toList();
  }

  @override
  Future<KeyStore> update<P>(P param) async {
    final keyStoreDto = await _keyStoreDatabaseService.update(
      (param as UpdateKeyStoreRequest).mapRequest,
    );

    return keyStoreDto.toEntity;
  }

  @override
  Future<void> deleteAll() {
    return _keyStoreDatabaseService.deleteAll();
  }
}

import 'package:data/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage;

  const SecureStorageServiceImpl(
    this._storage,
  );

  @override
  Future<bool> hadKey(String key) {
    return _storage.containsKey(
      key: key,
    );
  }

  @override
  Future<void> delete(String key) {
    return _storage.delete(
      key: key,
    );
  }

  @override
  Future<String?> get(String key) async{
    final bool constantKey = await hadKey(key);

    if(constantKey){
      return _storage.read(
        key: key,
      );
    }
    return null;
  }

  @override
  Future<void> save(String key, String value) {
    return _storage.write(
      key: key,
      value: value,
    );
  }
}

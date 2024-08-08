import 'package:data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class NormalStorageServiceImpl implements NormalStorageService {
  final SharedPreferences _storage;

  const NormalStorageServiceImpl(
    this._storage,
  );

  @override
  Future<void> delete(String key) {
    return _storage.remove(
      key,
    );
  }

  @override
  Future<String?> get(String key) async{
    return _storage.getString(
      key,
    );
  }

  @override
  Future<bool> hadKey(String key) async{
    return _storage.containsKey(
      key,
    );
  }

  @override
  Future<void> save(String key, String value) {
    return _storage.setString(
      key,
      value,
    );
  }
}

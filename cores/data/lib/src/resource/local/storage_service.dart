abstract interface class StorageService {
  Future<String?> get(String key);

  Future<bool> hadKey(String key);

  Future<void> delete(String key);

  Future<void> save(String key, String value);
}

// for secure service
abstract interface class SecureStorageService implements StorageService {}
// for normal service
abstract interface class NormalStorageService implements StorageService {}

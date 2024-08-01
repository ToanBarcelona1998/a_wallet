import 'package:data/data.dart';
import 'package:isar/isar.dart';
import 'key_store_db.dart';

final class KeyStoreDatabaseServiceImpl implements KeyStoreDatabaseService {
  final Isar _database;

  const KeyStoreDatabaseServiceImpl(this._database);

  @override
  Future<KeyStoreDto> add<P>(P param) async {
    final AddKeyStoreRequestDto p = param as AddKeyStoreRequestDto;
    KeyStoreDb keyStoreDb = KeyStoreDb(
      key: p.keyName,
    );
    await _database.writeTxn(
      () async {
        final id = await _database.keyStoreDbs.put(keyStoreDb);

        keyStoreDb = keyStoreDb.copyWith(
          id: id,
        );
      },
    );

    return keyStoreDb.toDto;
  }

  @override
  Future<void> delete(int id) async {
    return _database.writeTxn(
      () async {
        await _database.keyStoreDbs.delete(id);
      },
    );
  }

  @override
  Future<KeyStoreDto?> get(int id) async{
    final key = await _database.keyStoreDbs.get(id);

    return key?.toDto;
  }

  @override
  Future<List<KeyStoreDto>> getAll() async {
    final keyDbs = await _database.keyStoreDbs.where().findAll();

    return keyDbs.map((e) => e.toDto,).toList();
  }

  @override
  Future<KeyStoreDto> update<P>(P param) async {
    final UpdateKeyStoreRequestDto p = param as UpdateKeyStoreRequestDto;
    KeyStoreDb? keyStoreDb = await _database.keyStoreDbs.get(p.id);

    if (keyStoreDb != null) {
      keyStoreDb = keyStoreDb.copyWith(
        keyName: p.keyName,
      );

      await _database.writeTxn(
        () async {
          await _database.keyStoreDbs.put(
            keyStoreDb!,
          );
        },
      );

      return keyStoreDb.toDto;
    }

    throw Exception('Key store is not found');
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(() async{
      await _database.keyStoreDbs.where().deleteAll();
    },);
  }
}

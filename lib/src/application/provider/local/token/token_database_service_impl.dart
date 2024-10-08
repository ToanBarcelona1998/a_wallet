import 'package:data/data.dart';
import 'package:isar/isar.dart';

import 'token_db.dart';

final class TokenDatabaseServiceImpl implements TokenDatabaseService {
  final Isar _database;

  const TokenDatabaseServiceImpl(this._database);

  @override
  Future<TokenDto> add<P>(P param) async {
    TokenDb tokenDb = (param as AddTokenRequestDto).toTokenDb;

    await _database.writeTxn(
      () async {
        final id = await _database.tokenDbs.put(tokenDb);

        tokenDb = tokenDb.copyWith(
          id: id,
        );
      },
    );

    return tokenDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.tokenDbs.delete(id);
      },
    );
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(
      () async {
        await _database.tokenDbs.where().deleteAll();
      },
    );
  }

  @override
  Future<TokenDto?> get(int id) async {
    final token = await _database.tokenDbs.get(id);

    return token?.toDto;
  }

  @override
  Future<List<TokenDto>> getAll() async {
    final tokens = await _database.tokenDbs.where().findAll();

    return tokens
        .map(
          (e) => e.toDto,
        )
        .toList();
  }

  @override
  Future<TokenDto> update<P>(P param) async {
    final p = param as UpdateTokenRequestDto;

    TokenDb? tokenDb = await _database.tokenDbs.get(param.id);

    if (tokenDb == null) {
      throw Exception('Token not found');
    }

    tokenDb = tokenDb.copyWith(
      decimal: p.decimal,
      type: p.type?.name,
      logo: p.logo,
      name: p.tokenName,
      symbol: p.symbol,
      isEnable: p.isEnable,
      contract: p.contractAddress,
    );

    await _database.writeTxn(
      () async {
        await _database.tokenDbs.put(tokenDb!);
      },
    );

    return tokenDb.toDto;
  }

  @override
  Future<TokenDto?> getByName({required String name}) async {
    final token =
        await _database.tokenDbs.filter().tokenNameEqualTo(name).findFirst();

    return token?.toDto;
  }
}

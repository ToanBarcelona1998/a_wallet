import 'browser_db.dart';
import 'package:data/data.dart';
import 'package:isar/isar.dart';

final class BrowserDatabaseServiceImpl implements BrowserDatabaseService {
  final Isar _database;

  const BrowserDatabaseServiceImpl(this._database);

  @override
  Future<BrowserDto> add<P>(P param) async {
    BrowserDb browserDb = (param as AddBrowserParameterDto).toDb;

    final browsers =
        await _database.browserDbs.filter().isActiveEqualTo(true).findAll();

    await _database.writeTxn(
      () async {
        await _database.browserDbs.putAll(
          browsers.map((e) => e.copyWith(isActive: false)).toList(),
        );

        final id = await _database.browserDbs.put(browserDb);

        browserDb = browserDb.copyWith(id: id);
      },
    );

    return browserDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.browserDbs.delete(id);
      },
    );
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(
      () async {
        await _database.browserDbs.where().deleteAll();
      },
    );
  }

  @override
  Future<BrowserDto?> get(int id) async {
    final browserDb = await _database.browserDbs.get(id);

    return browserDb?.toDto;
  }

  @override
  Future<BrowserDto?> getActiveBrowser() async {
    final browserDb =
        await _database.browserDbs.filter().isActiveEqualTo(true).findFirst();

    return browserDb?.toDto;
  }

  @override
  Future<List<BrowserDto>> getAll() async {
    final browsersDb = await _database.browserDbs.where().findAll();

    return browsersDb
        .map(
          (e) => e.toDto,
        )
        .toList();
  }

  @override
  Future<BrowserDto> update<P>(P param) async {
    final UpdateBrowserParameterDto p = param as UpdateBrowserParameterDto;

    BrowserDb? browserDb = await _database.browserDbs.get(p.id);

    if (browserDb != null) {
      browserDb = browserDb.copyWith(
        url: p.url,
        screenShotUri: p.screenShotUri,
        logo: p.logo,
        title: p.siteName,
      );

      await _database.writeTxn(
        () async {
          await _database.browserDbs.put(browserDb!);
        },
      );

      return browserDb.toDto;
    }

    throw Exception('BrowserDb is not exists');
  }
}

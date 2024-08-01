import 'package:a_wallet/src/application/provider/local/book_mark/bookmark_db.dart';
import 'package:data/data.dart';
import 'package:isar/isar.dart';

final class BookMarkDatabaseServiceImpl implements BookMarkDatabaseService {
  final Isar _database;

  const BookMarkDatabaseServiceImpl(this._database);

  @override
  Future<BookMarkDto> add<P>(P param) async {
    BookMarkDb bookMarkDb = (param as AddBookMarkParameterDto).toDb;

    await _database.writeTxn(
      () async {
        final id = await _database.bookMarkDbs.put(bookMarkDb);

        bookMarkDb = bookMarkDb.copyWith(id: id);
      },
    );

    return bookMarkDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.bookMarkDbs.delete(id);
      },
    );
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(
      () async {
        await _database.bookMarkDbs.where().deleteAll();
      },
    );
  }

  @override
  Future<BookMarkDto?> get(int id) async {
    final bookMarkDb = await _database.bookMarkDbs.get(id);

    return bookMarkDb?.toDto;
  }

  @override
  Future<List<BookMarkDto>> getAll() async {
    final bookMarksDb = await _database.bookMarkDbs.where().findAll();

    return bookMarksDb
        .map(
          (e) => e.toDto,
        )
        .toList();
  }

  @override
  Future<BookMarkDto?> getBookMarkByUrl({required String url}) async {
    final bookMarkDb = await _database.bookMarkDbs.filter().urlEqualTo(
          url,
        ).findFirst();

    return bookMarkDb?.toDto;
  }

  @override
  Future<BookMarkDto> update<P>(P param) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

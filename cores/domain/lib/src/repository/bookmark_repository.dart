import 'package:domain/src/entities/bookmark.dart';
import 'local_database_repository.dart';

abstract interface class BookMarkRepository implements LocalDatabaseRepository<BookMark> {
  Future<BookMark?> getBookMarkByUrl({
    required String url,
  });
}

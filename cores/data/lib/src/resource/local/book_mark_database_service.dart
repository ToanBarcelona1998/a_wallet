import 'package:data/src/dto/bookmark_dto.dart';

import 'local_database_service.dart';

abstract interface class BookMarkDatabaseService
    implements LocalDatabaseService<BookMarkDto> {
  Future<BookMarkDto?> getBookMarkByUrl({
    required String url,
  });
}

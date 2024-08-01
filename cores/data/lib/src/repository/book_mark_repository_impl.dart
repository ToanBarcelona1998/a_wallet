import 'package:data/src/dto/bookmark_dto.dart';
import 'package:data/src/dto/request/add_bookmark_parameter_dto.dart';
import 'package:data/src/resource/local/book_mark_database_service.dart';
import 'package:domain/domain.dart';

final class BookMarkRepositoryImpl implements BookMarkRepository {
  final BookMarkDatabaseService _bookMarkDatabaseService;

  const BookMarkRepositoryImpl(this._bookMarkDatabaseService);

  @override
  Future<BookMark> add<P>(P param) async {
    final bookMarkDto = await _bookMarkDatabaseService.add(
      (param as AddBookMarkParameter).mapRequest,
    );

    return bookMarkDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _bookMarkDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _bookMarkDatabaseService.deleteAll();
  }

  @override
  Future<BookMark?> get(int id) async{
    final boolMarkDto = await _bookMarkDatabaseService.get(id);

    return boolMarkDto?.toEntity;
  }

  @override
  Future<List<BookMark>> getAll() async{
    final bookMarksDto = await _bookMarkDatabaseService.getAll();

    return bookMarksDto.map((e) => e.toEntity,).toList();
  }

  @override
  Future<BookMark?> getBookMarkByUrl({required String url}) async{
    final bookMarkDto = await _bookMarkDatabaseService.getBookMarkByUrl(url: url);

    return bookMarkDto?.toEntity;
  }

  @override
  Future<BookMark> update<P>(P param) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

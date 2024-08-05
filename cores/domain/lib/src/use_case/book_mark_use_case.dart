import 'package:domain/src/entities/bookmark.dart';
import 'package:domain/src/entities/request/add_bookmark_parameter.dart';
import 'package:domain/src/repository/bookmark_repository.dart';

final class BookMarkUseCase {
  final BookMarkRepository _bookMarkRepository;
  
  const BookMarkUseCase(this._bookMarkRepository);


  Future<BookMark> add(AddBookMarkParameter param){
    return _bookMarkRepository.add(param);
  }

  Future<void> delete(int id){
    return _bookMarkRepository.delete(id);
  }

  Future<BookMark?> get(int id){
    return _bookMarkRepository.get(id);
  }

  Future<List<BookMark>> getAll(){
    return _bookMarkRepository.getAll();
  }

  Future<void> deleteAll(){
    return _bookMarkRepository.deleteAll();
  }
}
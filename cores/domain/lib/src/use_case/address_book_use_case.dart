import 'package:domain/src/entities/address_book.dart';
import 'package:domain/src/entities/request/add_address_book_request.dart';
import 'package:domain/src/entities/request/update_address_book_request.dart';
import 'package:domain/src/repository/address_book_repository.dart';

final class AddressBookUseCase {
  final AddressBookRepository _addressBookRepository;

  const AddressBookUseCase(this._addressBookRepository);


  Future<AddressBook> add(AddAddressBookRequest param){
    return _addressBookRepository.add(param);
  }

  Future<void> delete(int id){
    return _addressBookRepository.delete(id);
  }

  Future<AddressBook> update(UpdateAddressBookRequest param){
    return _addressBookRepository.update(param);
  }

  Future<AddressBook?> get(int id){
    return _addressBookRepository.get(id);
  }

  Future<List<AddressBook>> getAll(){
    return _addressBookRepository.getAll();
  }

  Future<void> deleteAll(){
    return _addressBookRepository.deleteAll();
  }
}
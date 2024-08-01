import 'package:data/src/dto/address_book_dto.dart';
import 'package:data/src/dto/request/add_address_book_request_dto.dart';
import 'package:data/src/dto/request/update_address_book_request_dto.dart';
import 'package:data/src/resource/local/address_book_database_service.dart';
import 'package:domain/domain.dart';

final class AddressBookRepositoryImpl implements AddressBookRepository {
  final AddressBookDatabaseService _addressBookDatabaseService;

  const AddressBookRepositoryImpl(this._addressBookDatabaseService);

  @override
  Future<AddressBook> add<P>(P param) async {
    final addressBookDto = await _addressBookDatabaseService.add(
      (param as AddAddressBookRequest).mapRequest,
    );

    return addressBookDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _addressBookDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _addressBookDatabaseService.deleteAll();
  }

  @override
  Future<AddressBook?> get(int id) async {
    final addressBookDto = await _addressBookDatabaseService.get(id);

    return addressBookDto?.toEntity;
  }

  @override
  Future<List<AddressBook>> getAll() async {
    final addressBooksDto = await _addressBookDatabaseService.getAll();

    return addressBooksDto
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }

  @override
  Future<AddressBook> update<P>(P param) async {
    final addressBookDto = await _addressBookDatabaseService.update(
      (param as UpdateAddressBookRequest).mapRequest,
    );

    return addressBookDto.toEntity;
  }
}

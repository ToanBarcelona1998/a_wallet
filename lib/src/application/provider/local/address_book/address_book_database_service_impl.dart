import 'package:data/data.dart';
import 'package:isar/isar.dart';

import 'address_book_db.dart';

final class AddressBookDatabaseServiceImpl
    implements AddressBookDatabaseService {
  final Isar _database;

  const AddressBookDatabaseServiceImpl(this._database);

  @override
  Future<AddressBookDto> add<P>(P param) async {
    AddressBookDb addressBookDb = (param as AddAddressBookRequestDto).toDb;

    await _database.writeTxn(
      () async {
        final int id = await _database.addressBookDbs.put(addressBookDb);

        addressBookDb = addressBookDb.copyWith(id: id);
      },
    );

    return addressBookDb.toDto;
  }

  @override
  Future<void> delete(int id) {
    return _database.writeTxn(
      () async {
        await _database.addressBookDbs.delete(id);
      },
    );
  }

  @override
  Future<void> deleteAll() {
    return _database.writeTxn(
      () async {
        await _database.addressBookDbs.where().deleteAll();
      },
    );
  }

  @override
  Future<AddressBookDto?> get(int id) async {
    final addressBookDb = await _database.addressBookDbs.get(id);

    return addressBookDb?.toDto;
  }

  @override
  Future<List<AddressBookDto>> getAll() async {
    final addressBooksDb = await _database.addressBookDbs.where().findAll();

    return addressBooksDb
        .map(
          (e) => e.toDto,
        )
        .toList();
  }

  @override
  Future<AddressBookDto> update<P>(P param) async{
    final UpdateAddressBookRequestDto updateAddressBookRequestDto = param as UpdateAddressBookRequestDto;

    AddressBookDb ? addressBookDb = await _database.addressBookDbs.get(updateAddressBookRequestDto.id);

    if(addressBookDb != null){
      addressBookDb = addressBookDb.copyWith(
        address: updateAddressBookRequestDto.address,
        name: updateAddressBookRequestDto.name,
      );

      await _database.writeTxn(() async{
        await _database.addressBookDbs.put(addressBookDb!);
      },);

      return addressBookDb.toDto;
    }

    throw Exception('AddressBookDto is not exists');
  }
}

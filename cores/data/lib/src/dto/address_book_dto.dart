import 'package:domain/domain.dart';

extension AddressBookDtoMapper on AddressBookDto {
  AddressBook get toEntity => AddressBook(
        id: id,
        address: address,
        name: name,
      );
}

class AddressBookDto {
  final int id;
  final String name;
  final String address;

  const AddressBookDto({
    required this.id,
    required this.address,
    required this.name,
  });
}

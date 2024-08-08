import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'address_book_db.g.dart';

extension AddAddressBookRequestDtoMapper on AddAddressBookRequestDto {
  AddressBookDb get toDb => AddressBookDb(
        address: address,
        name: name,
      );
}

extension AddressBookDbExtension on AddressBookDb {
  AddressBookDb copyWith({
    int? id,
    String? name,
    String? address,
  }) {
    return AddressBookDb(
      address: address ?? this.address,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  AddressBookDto get toDto => AddressBookDto(
        id: id,
        address: address,
        name: name,
      );
}

@Collection(
  inheritance: false,
)
final class AddressBookDb {
  final String address;
  final String name;
  final Id id;

  const AddressBookDb({
    required this.address,
    required this.name,
    this.id = Isar.autoIncrement,
  });
}

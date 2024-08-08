import 'package:domain/domain.dart';

extension AddAddressBookRequestMapper on AddAddressBookRequest {
  AddAddressBookRequestDto get mapRequest => AddAddressBookRequestDto(
        name: name,
        address: address,
      );
}

final class AddAddressBookRequestDto {
  final String name;
  final String address;

  const AddAddressBookRequestDto({
    required this.name,
    required this.address,
  });
}

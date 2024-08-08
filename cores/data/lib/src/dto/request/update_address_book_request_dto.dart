import 'package:domain/domain.dart';

extension UpdateAddressBookRequestMapper on UpdateAddressBookRequest {
  UpdateAddressBookRequestDto get mapRequest => UpdateAddressBookRequestDto(
        id: id,
        name: name,
        address: address,
      );
}

final class UpdateAddressBookRequestDto {
  final String? name;
  final String? address;
  final int id;

  const UpdateAddressBookRequestDto({
    required this.id,
    this.address,
    this.name,
  });
}

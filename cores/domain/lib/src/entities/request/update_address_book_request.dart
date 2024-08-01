final class UpdateAddressBookRequest {
  final String? name;
  final String? address;
  final int id;

  const UpdateAddressBookRequest({
    required this.id,
    this.address,
    this.name,
  });
}

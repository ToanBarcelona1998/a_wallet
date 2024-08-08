final class UpdateAccountRequest {
  final String? name;
  final String? evmAddress;
  final int? keyStoreId;
  final int id;
  final int? index;

  const UpdateAccountRequest({
    this.index,
    this.name,
    this.keyStoreId,
    this.evmAddress,
    required this.id,
  });
}


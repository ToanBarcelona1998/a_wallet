final class UpdateAccountRequest {
  final String? name;
  final UpdateAEvmInfoRequest? updateAEvmInfoRequest;
  final UpdateACosmosInfoRequest? updateACosmosInfoRequest;
  final int? keyStoreId;
  final int id;
  final int? index;

  const UpdateAccountRequest({
    this.index,
    this.name,
    this.keyStoreId,
    this.updateAEvmInfoRequest,
    this.updateACosmosInfoRequest,
    required this.id,
  });
}

final class UpdateAEvmInfoRequest {
  final String address;
  final bool isActive;

  const UpdateAEvmInfoRequest({
    required this.address,
    required this.isActive,
  });
}

final class UpdateACosmosInfoRequest {
  final String address;
  final bool isActive;

  const UpdateACosmosInfoRequest({
    required this.address,
    required this.isActive,
  });
}


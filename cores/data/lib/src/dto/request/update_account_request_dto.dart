import 'package:domain/domain.dart';

extension UpdateAccountRequestMapper on UpdateAccountRequest {
  UpdateAccountRequestDto get mapRequest => UpdateAccountRequestDto(
        keyStoreId: keyStoreId,
        name: name,
        id: id,
        index: index,
        updateACosmosInfoRequest: updateACosmosInfoRequest?.mapRequest,
        updateAEvmInfoRequest: updateAEvmInfoRequest?.mapRequest,
      );
}

extension UpdateAEvmInfoRequestMapper on UpdateAEvmInfoRequest {
  UpdateAEvmInfoRequestDto get mapRequest => UpdateAEvmInfoRequestDto(
        address: address,
        isActive: isActive,
      );
}

extension UpdateACosmosInfoRequestMapper on UpdateACosmosInfoRequest {
  UpdateACosmosInfoRequestDto get mapRequest => UpdateACosmosInfoRequestDto(
        address: address,
        isActive: isActive,
      );
}

final class UpdateAccountRequestDto {
  final String? name;
  final UpdateAEvmInfoRequestDto? updateAEvmInfoRequest;
  final UpdateACosmosInfoRequestDto? updateACosmosInfoRequest;
  final int? keyStoreId;
  final int? index;
  final int id;

  const UpdateAccountRequestDto({
    this.index,
    this.name,
    this.keyStoreId,
    this.updateAEvmInfoRequest,
    this.updateACosmosInfoRequest,
    required this.id,
  });
}

final class UpdateAEvmInfoRequestDto {
  final String address;
  final bool isActive;

  const UpdateAEvmInfoRequestDto({
    required this.address,
    required this.isActive,
  });
}

final class UpdateACosmosInfoRequestDto {
  final String address;
  final bool isActive;

  const UpdateACosmosInfoRequestDto({
    required this.address,
    required this.isActive,
  });
}

import 'package:domain/domain.dart';

extension AddAccountRequestMapper on AddAccountRequest {
  AddAccountRequestDto get mapRequest => AddAccountRequestDto(
        name: name,
        keyStoreId: keyStoreId,
        createType: createType,
        type: type,
        controllerKeyType: controllerKeyType,
        index: index,
        addACosmosInfoRequest: addACosmosInfoRequest.mapRequest,
        addAEvmInfoRequest: addAEvmInfoRequest.mapRequest,
      );
}

extension AddAEvmInfoRequestMapper on AddAEvmInfoRequest {
  AddAEvmInfoRequestDto get mapRequest => AddAEvmInfoRequestDto(
        address: address,
        isActive: isActive,
      );
}

extension AddACosmosInfoRequestMapper on AddACosmosInfoRequest {
  AddACosmosInfoRequestDto get mapRequest => AddACosmosInfoRequestDto(
        address: address,
        isActive: isActive,
      );
}

final class AddAccountRequestDto {
  final String name;
  final int index;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;
  final AddAEvmInfoRequestDto addAEvmInfoRequest;
  final AddACosmosInfoRequestDto addACosmosInfoRequest;

  const AddAccountRequestDto({
    required this.name,
    required this.index,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
    required this.addAEvmInfoRequest,
    required this.addACosmosInfoRequest,
  });
}

final class AddAEvmInfoRequestDto {
  final String address;
  final bool isActive;

  const AddAEvmInfoRequestDto({
    required this.address,
    required this.isActive,
  });
}

final class AddACosmosInfoRequestDto {
  final String address;
  final bool isActive;

  const AddACosmosInfoRequestDto({
    required this.address,
    required this.isActive,
  });
}

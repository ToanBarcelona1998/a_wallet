import 'package:domain/domain.dart';

extension AccountDtoMapper on AccountDto {
  Account get toEntity => Account(
        id: id,
        name: name,
        evmAddress: evmAddress,
        keyStoreId: keyStoreId,
        cosmosAddress: cosmosAddress,
        createType: createType,
        type: type,
        controllerKeyType: controllerKeyType,
        index: index,
        aCosmosInfo: aCosmosInfo.toEntity,
        aEvmInfo: aEvmInfo.toEntity,
      );
}

extension AEvmInfoDtoMapper on AEvmInfoDto {
  AEvmInfo get toEntity => AEvmInfo(
        address: address,
        isActive: isActive,
      );
}

extension ACosmosInfoDtoMapper on ACosmosInfoDto {
  ACosmosInfo get toEntity => ACosmosInfo(
        address: address,
        isActive: isActive,
      );
}

class AccountDto {
  final int id;
  final int index;
  final String name;
  @Deprecated('Replace by AEvmInfoDto')
  final String evmAddress;
  @Deprecated('Replace by ACosmosInfoDto')
  final String? cosmosAddress;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  final AEvmInfoDto aEvmInfo;
  final ACosmosInfoDto aCosmosInfo;

  const AccountDto({
    required this.id,
    required this.index,
    required this.name,
    required this.evmAddress,
    this.cosmosAddress,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
    required this.aEvmInfo,
    required this.aCosmosInfo,
  });
}

class AEvmInfoDto {
  final String address;
  final bool isActive;

  const AEvmInfoDto({
    required this.address,
    required this.isActive,
  });
}

class ACosmosInfoDto {
  final String address;
  final bool isActive;

  const ACosmosInfoDto({
    required this.address,
    required this.isActive,
  });
}

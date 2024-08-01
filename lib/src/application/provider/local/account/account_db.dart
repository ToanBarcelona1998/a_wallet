import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:isar/isar.dart';

part 'account_db.g.dart';

extension AddAEvmInfoRequestDtoMapper on AddAEvmInfoRequestDto {
  AEvmInfoDb get mapRequestToDb => AEvmInfoDb(
        address: address,
        isActive: isActive,
      );
}

extension AddACosmosInfoRequestDtoMapper on AddACosmosInfoRequestDto {
  ACosmosInfoDb get mapRequestToDb => ACosmosInfoDb(
        address: address,
        isActive: isActive,
      );
}

extension AddAccountRequestDtoMapper on AddAccountRequestDto {
  AccountDb get mapRequestToDb => AccountDb(
        index: index,
        name: name,
        evmAddress: '',
        keyStoreId: keyStoreId,
        aCosmosInfo: addACosmosInfoRequest.mapRequestToDb,
        aEvmInfo: addAEvmInfoRequest.mapRequestToDb,
        controllerKeyType: controllerKeyType,
        type: type,
        createType: createType,
      );
}

extension UpdateAEvmInfoRequestDtoMapper on UpdateAEvmInfoRequestDto {
  AEvmInfoDb get mapRequestToDb => AEvmInfoDb(
        address: address,
        isActive: isActive,
      );
}

extension UpdateACosmosInfoRequestDtoMapper on UpdateACosmosInfoRequestDto {
  ACosmosInfoDb get mapRequestToDb => ACosmosInfoDb(
        address: address,
        isActive: isActive,
      );
}

extension AccountDbExtension on AccountDb {
  AccountDb copyWith({
    String? name,
    int? keyStoreId,
    int? id,
    int? index,
    AccountCreateType? createType,
    AccountType? type,
    ControllerKeyType? controllerKeyType,
    AEvmInfoDb? aEvmInfoDb,
    ACosmosInfoDb? aCosmosInfoDb,
  }) {
    return AccountDb(
        name: name ?? this.name,
        keyStoreId: keyStoreId ?? this.keyStoreId,
        type: type ?? this.type,
        createType: createType ?? this.createType,
        id: id ?? this.id,
        controllerKeyType: controllerKeyType ?? this.controllerKeyType,
        index: index ?? this.index,
        aEvmInfo: aEvmInfoDb ?? aEvmInfo,
        aCosmosInfo: aCosmosInfoDb ?? aCosmosInfo,
        evmAddress: '');
  }

  AccountDto get toDto => AccountDto(
        id: id,
        index: index,
        name: name,
        evmAddress: evmAddress,
        keyStoreId: keyStoreId,
        aEvmInfo: aEvmInfo.toDto,
        aCosmosInfo: aCosmosInfo.toDto,
        type: type,
        createType: createType,
        controllerKeyType: controllerKeyType,
      );
}

extension AEvmInfoDbMapper on AEvmInfoDb {
  AEvmInfoDto get toDto => AEvmInfoDto(
        address: address,
        isActive: isActive,
      );
}

extension ACosmosInfoDbMapper on ACosmosInfoDb {
  ACosmosInfoDto get toDto => ACosmosInfoDto(
        address: address,
        isActive: isActive,
      );
}

@Collection(inheritance: false)
final class AccountDb {
  final Id id;
  final int index;
  final String name;
  @Deprecated('Replace by AEvmInfoDto')
  final String evmAddress;
  @Deprecated('Replace by ACosmosInfoDto')
  final String? cosmosAddress;
  final int keyStoreId;
  @enumerated
  final AccountType type;
  @enumerated
  final AccountCreateType createType;
  @enumerated
  final ControllerKeyType controllerKeyType;

  final AEvmInfoDb aEvmInfo;
  final ACosmosInfoDb aCosmosInfo;

  AccountDb({
    this.id = Isar.autoIncrement,
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

@embedded
class AEvmInfoDb {
  final String address;
  final bool isActive;

  const AEvmInfoDb({
    this.address = '',
    this.isActive = false,
  });
}

@embedded
class ACosmosInfoDb {
  final String address;
  final bool isActive;

  const ACosmosInfoDb({
    this.address = '',
    this.isActive = false,
  });
}

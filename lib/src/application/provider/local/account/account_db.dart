import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:isar/isar.dart';

part 'account_db.g.dart';

extension AddAccountRequestDtoMapper on AddAccountRequestDto {
  AccountDb get mapRequestToDb => AccountDb(
        index: index,
        name: name,
        evmAddress: evmAddress,
        keyStoreId: keyStoreId,
        controllerKeyType: controllerKeyType,
        type: type,
        createType: createType,
      );
}

extension AccountDbExtension on AccountDb {
  AccountDb copyWith({
    String? name,
    String? evmAddress,
    int? keyStoreId,
    int? id,
    int? index,
    AccountCreateType? createType,
    AccountType? type,
    ControllerKeyType? controllerKeyType,
  }) {
    return AccountDb(
      name: name ?? this.name,
      keyStoreId: keyStoreId ?? this.keyStoreId,
      type: type ?? this.type,
      createType: createType ?? this.createType,
      id: id ?? this.id,
      controllerKeyType: controllerKeyType ?? this.controllerKeyType,
      index: index ?? this.index,
      evmAddress: evmAddress ?? this.evmAddress,
    );
  }

  AccountDto get toDto => AccountDto(
        id: id,
        index: index,
        name: name,
        evmAddress: evmAddress,
        keyStoreId: keyStoreId,
        type: type,
        createType: createType,
        controllerKeyType: controllerKeyType,
      );
}

@Collection(inheritance: false)
final class AccountDb {
  final Id id;
  final int index;
  final String name;
  final String evmAddress;
  final int keyStoreId;
  @enumerated
  final AccountType type;
  @enumerated
  final AccountCreateType createType;
  @enumerated
  final ControllerKeyType controllerKeyType;

  AccountDb({
    this.id = Isar.autoIncrement,
    required this.index,
    required this.name,
    required this.evmAddress,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
  });
}

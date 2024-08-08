import 'package:domain/domain.dart';

extension AccountDtoMapper on AccountDto {
  Account get toEntity => Account(
        id: id,
        name: name,
        evmAddress: evmAddress,
        keyStoreId: keyStoreId,
        createType: createType,
        type: type,
        controllerKeyType: controllerKeyType,
        index: index,
      );
}

final class AccountDto {
  final int id;
  final int index;
  final String name;
  final String evmAddress;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  const AccountDto({
    required this.id,
    required this.index,
    required this.name,
    required this.evmAddress,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
  });
}

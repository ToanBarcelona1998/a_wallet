import 'package:domain/core/enum.dart';

final class Account {
  final int id;

  // 0 -> active 1. normal
  final int index;
  final String name;
  final String evmAddress;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  const Account({
    required this.id,
    required this.index,
    required this.name,
    required this.evmAddress,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
  });

  bool get isAbstractAccount => type == AccountType.abstraction;
}

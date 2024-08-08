import 'package:domain/domain.dart';

final class AddAccountRequest {
  final int index;
  final String name;
  final String evmAddress;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  const AddAccountRequest({
    required this.index,
    required this.name,
    required this.keyStoreId,
    required this.evmAddress,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
  });
}

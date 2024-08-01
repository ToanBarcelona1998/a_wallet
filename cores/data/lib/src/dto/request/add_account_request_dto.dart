import 'package:domain/domain.dart';

extension AddAccountRequestMapper on AddAccountRequest {
  AddAccountRequestDto get mapRequest => AddAccountRequestDto(
        name: name,
        keyStoreId: keyStoreId,
        createType: createType,
        type: type,
        controllerKeyType: controllerKeyType,
        index: index,
        evmAddress: evmAddress,
      );
}

final class AddAccountRequestDto {
  final String name;
  final String evmAddress;
  final int index;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  const AddAccountRequestDto({
    required this.name,
    required this.index,
    required this.keyStoreId,
    required this.evmAddress,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
  });
}

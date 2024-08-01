import 'package:domain/domain.dart';

final class AddAccountRequest {
  final int index;
  final String name;
  final int keyStoreId;
  final AccountType type;
  final AccountCreateType createType;
  final ControllerKeyType controllerKeyType;

  final AddAEvmInfoRequest addAEvmInfoRequest;
  final AddACosmosInfoRequest addACosmosInfoRequest;

  const AddAccountRequest({
    required this.index,
    required this.name,
    required this.keyStoreId,
    this.type = AccountType.normal,
    this.createType = AccountCreateType.normal,
    this.controllerKeyType = ControllerKeyType.passPhrase,
    required this.addACosmosInfoRequest,
    required this.addAEvmInfoRequest,
  });
}

final class AddAEvmInfoRequest {
  final String address;
  final bool isActive;

  const AddAEvmInfoRequest({
    required this.address,
    required this.isActive,
  });
}

final class AddACosmosInfoRequest {
  final String address;
  final bool isActive;

  const AddACosmosInfoRequest({
    required this.address,
    required this.isActive,
  });
}

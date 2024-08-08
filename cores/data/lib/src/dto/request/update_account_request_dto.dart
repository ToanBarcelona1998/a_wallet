import 'package:domain/domain.dart';

extension UpdateAccountRequestMapper on UpdateAccountRequest {
  UpdateAccountRequestDto get mapRequest => UpdateAccountRequestDto(
        keyStoreId: keyStoreId,
        name: name,
        id: id,
        index: index,
        evmAddress: evmAddress,
      );
}

final class UpdateAccountRequestDto {
  final String? name;
  final String? evmAddress;
  final int? keyStoreId;
  final int? index;
  final int id;

  const UpdateAccountRequestDto({
    this.index,
    this.evmAddress,
    this.name,
    this.keyStoreId,
    required this.id,
  });
}

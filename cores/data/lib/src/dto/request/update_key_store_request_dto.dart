import 'package:domain/domain.dart';

extension UpdateKeyStoreRequestMapper on UpdateKeyStoreRequest {
  UpdateKeyStoreRequestDto get mapRequest => UpdateKeyStoreRequestDto(
        keyName: keyName,
        id: id,
      );
}

final class UpdateKeyStoreRequestDto {
  final String? keyName;
  final int id;

  const UpdateKeyStoreRequestDto({
    this.keyName,
    required this.id,
  });
}

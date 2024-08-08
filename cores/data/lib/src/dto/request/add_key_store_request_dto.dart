import 'package:domain/domain.dart';

extension AddKeyStoreRequestMapper on AddKeyStoreRequest {
  AddKeyStoreRequestDto get mapRequest => AddKeyStoreRequestDto(
        keyName: keyName,
      );
}

final class AddKeyStoreRequestDto {
  final String keyName;

  const AddKeyStoreRequestDto({
    required this.keyName,
  });
}

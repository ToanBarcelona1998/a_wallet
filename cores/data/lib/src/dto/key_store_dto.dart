import 'package:domain/domain.dart';

extension KeyStoreMapper on KeyStoreDto {
  KeyStore get toEntity => KeyStore(
        key: key,
        id: id,
      );
}

class KeyStoreDto {
  final int id;
  final String key;

  const KeyStoreDto({
    required this.key,
    required this.id,
  });
}

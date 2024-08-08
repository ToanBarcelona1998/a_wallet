import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'key_store_db.g.dart';

extension KeyStoreDbExtension on KeyStoreDb {
  KeyStoreDb copyWith({
    String? keyName,
    int? id,
  }) {
    return KeyStoreDb(
      key: keyName ?? key,
      id: id ?? this.id,
    );
  }

  KeyStoreDto get toDto => KeyStoreDto(
        key: key,
        id: id,
      );
}

@Collection(
  inheritance: false,
)
final class KeyStoreDb {
  final Id id;
  final String key;

  KeyStoreDb({
    required this.key,
    this.id = Isar.autoIncrement,
  });
}

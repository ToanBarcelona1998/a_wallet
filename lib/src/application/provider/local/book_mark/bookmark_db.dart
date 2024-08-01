import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'bookmark_db.g.dart';

extension AddBookMarkRequestDtoMapper on AddBookMarkParameterDto {
  BookMarkDb get toDb => BookMarkDb(
        name: name,
        logo: logo,
        url: url,
        description: description,
      );
}

extension BookMarkDbExtension on BookMarkDb {
  BookMarkDb copyWith({
    int? id,
    String? name,
    String? logo,
    String? url,
    String? description,
  }) {
    return BookMarkDb(
      name: name ?? this.name,
      logo: logo ?? this.logo,
      url: url ?? this.url,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  BookMarkDto get toDto => BookMarkDto(
        id: id,
        logo: logo,
        name: name,
        url: url,
        description: description,
      );
}

@Collection(
  inheritance: false,
)
final class BookMarkDb {
  final Id id;
  final String name;
  final String logo;
  final String? description;
  final String url;

  BookMarkDb({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.logo,
    required this.url,
    this.description,
  });
}

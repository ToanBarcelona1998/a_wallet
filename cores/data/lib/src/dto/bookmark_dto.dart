import 'package:domain/domain.dart';

extension BookMarkDtoMapper on BookMarkDto {
  BookMark get toEntity => BookMark(
        id: id,
        logo: logo,
        name: name,
        url: url,
        description: description,
      );
}

class BookMarkDto {
  final int id;
  final String logo;
  final String name;
  final String? description;
  final String url;

  const BookMarkDto({
    required this.id,
    required this.logo,
    required this.name,
    this.description,
    required this.url,
  });
}

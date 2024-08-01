import 'package:domain/domain.dart';

extension AddBookMarkParameterMapper on AddBookMarkParameter {
  AddBookMarkParameterDto get mapRequest => AddBookMarkParameterDto(
        logo: logo,
        name: name,
        url: url,
        description: description,
      );
}

final class AddBookMarkParameterDto {
  final String logo;
  final String name;
  final String? description;
  final String url;

  const AddBookMarkParameterDto({
    required this.logo,
    required this.name,
    this.description,
    required this.url,
  });
}

import 'package:domain/domain.dart';

extension FunctionMappingDtoMapper on FunctionMappingDto {
  FunctionMapping get toEntity => FunctionMapping(
        id: id,
        topic: topic,
      );
}

final class FunctionMappingDto {
  final String id;
  final String topic;

  const FunctionMappingDto({
    required this.id,
    required this.topic,
  });

  factory FunctionMappingDto.fromJson(Map<String, dynamic> json) {
    return FunctionMappingDto(
      id: json['function_id'],
      topic: json['human_readable_topic'],
    );
  }
}

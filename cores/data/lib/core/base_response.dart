import 'package:domain/domain.dart';

abstract class BaseResponse<T> {
  final T? data;

  const BaseResponse({this.data});
}

final class AuraBaseResponseV2<T> extends BaseResponse<T> {
  final int code;
  final String message;

  const AuraBaseResponseV2({
    required this.code,
    super.data,
    required this.message,
  });

  factory AuraBaseResponseV2.fromJson(Map<String, dynamic> json) {
    return AuraBaseResponseV2(
      code: json['code'],
      data: json['data'],
      message: json['message'],
    );
  }

  T? handleResponse() {
    if (code == 200) {
      return data;
    }

    throw AppError(
      error: message,
      code: code.toString(),
    );
  }
}

final class AuraBaseResponseV1<T> extends BaseResponse<T> {
  const AuraBaseResponseV1({
    super.data,
  });

  factory AuraBaseResponseV1.fromJson(T json) {
    return AuraBaseResponseV1(
      data: json,
    );
  }
}

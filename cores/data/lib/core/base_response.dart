import 'package:domain/domain.dart';

abstract class BaseResponse<T> {
  final T? data;

  const BaseResponse({this.data});
}

final class XWalletBaseResponseV2<T> extends BaseResponse<T> {
  final int code;
  final String message;

  const XWalletBaseResponseV2({
    required this.code,
    super.data,
    required this.message,
  });

  factory XWalletBaseResponseV2.fromJson(Map<String, dynamic> json) {
    return XWalletBaseResponseV2(
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

final class XWalletBaseResponseV1<T> extends BaseResponse<T> {
  const XWalletBaseResponseV1({
    super.data,
  });

  factory XWalletBaseResponseV1.fromJson(T json) {
    return XWalletBaseResponseV1(
      data: json,
    );
  }
}

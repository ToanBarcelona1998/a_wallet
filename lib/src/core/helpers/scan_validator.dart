import 'package:a_wallet/src/core/helpers/address_validator.dart';

enum ScanResultType {
  address,
  walletConnect,
  other,
}

final class ScanResult {
  final String raw;
  final ScanResultType type;

  const ScanResult({
    required this.raw,
    this.type = ScanResultType.other,
  });

  ScanResult copyWith({
    String? raw,
    ScanResultType? type,
  }) {
    return ScanResult(
      raw: raw ?? this.raw,
      type: type ?? this.type,
    );
  }
}

sealed class ScanValidator {
  static const String wcPrefix = 'wc:';

  static ScanResult validateResult(String raw) {
    ScanResult result = ScanResult(
      raw: raw,
    );
    if (raw.startsWith(wcPrefix)) {
      result = result.copyWith(
        type: ScanResultType.walletConnect,
      );
    } else if (addressInValid(
      address: raw,
    )) {
      result = result.copyWith(
        type: ScanResultType.address,
      );
    }

    return result;
  }
}

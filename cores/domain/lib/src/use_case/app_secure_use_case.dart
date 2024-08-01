import 'package:domain/src/repository/app_secure_repository.dart';

final class AppSecureUseCase {
  final AppSecureRepository _repository;

  const AppSecureUseCase(this._repository);

  Future<bool> hasPasscode({required String key}) async {
    final String? passcode = await _repository.getCurrentPasscode(key: key);
    return passcode != null && passcode.isNotEmpty;
  }

  Future<String?> getCurrentPasscode({
    required String key,
  }) async {
    return _repository.getCurrentPasscode(key: key);
  }

  Future<void> storePasscode({
    required String key,
    required String passcode,
  }) {
    return _repository.storePasscode(
      key: key,
      passcode: passcode,
    );
  }

  Future<bool> isEnableBiometric({
    required String key,
  }) async {
    String? value = await _repository.getCurrentStateBiometric(key: key);
    return value != null && value == 'true';
  }

  Future<void> enableBiometrics({
    required String key,
    required bool setBioValue,
  }) async {
    return _repository.enableBiometrics(
      key: key,
      value: setBioValue.toString(),
    );
  }

  Future<bool> canAuthenticateWithBiometrics() {
    return _repository.canAuthenticateWithBiometrics();
  }

  Future<bool> requestBiometric({
    String? localizedReason,
    String? androidSignTitle,
    String? cancelButton,
  }) {
    return _repository.requestBiometric(
      androidSignTitle: androidSignTitle,
      cancelButton: cancelButton,
      localizedReason: localizedReason,
    );
  }
}

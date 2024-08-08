abstract interface class AppSecureRepository {
  Future<void> storePasscode({
    required String key,
    required String passcode,
  });

  Future<String?> getCurrentPasscode({
    required String key,
  });

  Future<bool> hasPasscode({
    required String key,
  });

  Future<bool> canAuthenticateWithBiometrics();

  Future<bool> requestBiometric({
    String? localizedReason,
    String? androidSignTitle,
    String? cancelButton,
  });

  Future<void> enableBiometrics({
    required String key,
    required String value,
  });

  Future<String?> getCurrentStateBiometric({
    required String key,
  });
}

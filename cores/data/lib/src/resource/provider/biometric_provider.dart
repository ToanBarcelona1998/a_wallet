abstract interface class BiometricProvider{
  Future<bool> canAuthenticateWithBiometrics();

  Future<bool> requestBiometric({
    String? localizedReason,
    String? androidSignTitle,
    String? cancelButton,
  });
}
import 'package:data/src/resource/provider/biometric_provider.dart';
import 'package:data/src/resource/local/storage_service.dart';
import 'package:domain/domain.dart';

final class AppSecureRepositoryImpl implements AppSecureRepository {
  final StorageService _storageService;
  final BiometricProvider _biometricService;

  const AppSecureRepositoryImpl(this._storageService, this._biometricService);

  @override
  Future<String?> getCurrentPasscode({required String key}) async {
    return _storageService.get(key);
  }

  @override
  Future<bool> canAuthenticateWithBiometrics() {
    return _biometricService.canAuthenticateWithBiometrics();
  }

  @override
  Future<String?> getCurrentStateBiometric({required String key}) {
    return _storageService.get(key);
  }

  @override
  Future<bool> hasPasscode({required String key}) {
    return _storageService.hadKey(key);
  }

  @override
  Future<bool> requestBiometric(
      {String? localizedReason,
      String? androidSignTitle,
      String? cancelButton}) {
    return _biometricService.requestBiometric(
      localizedReason: localizedReason,
      cancelButton: cancelButton,
      androidSignTitle: androidSignTitle,
    );
  }

  @override
  Future<void> enableBiometrics({required String key, required String value}) {
    return _storageService.save(key, value);
  }

  @override
  Future<void> storePasscode({required String key, required String passcode}) {
    return _storageService.save(key, passcode);
  }
}

import 'package:data/data.dart';

final class BiometricProviderImpl implements BiometricProvider{
  @override
  Future<bool> canAuthenticateWithBiometrics() {
    // TODO: implement canAuthenticateWithBiometrics
    throw UnimplementedError();
  }

  @override
  Future<bool> requestBiometric({String? localizedReason, String? androidSignTitle, String? cancelButton}) {
    // TODO: implement requestBiometric
    throw UnimplementedError();
  }
  
}
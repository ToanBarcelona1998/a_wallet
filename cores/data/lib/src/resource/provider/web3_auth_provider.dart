import 'package:data/src/dto/google_account_dto.dart';
import 'package:domain/domain.dart';

abstract interface class Web3AuthProvider {

  Future<GoogleAccountDto?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  });

  Future<void> logout();

  Future<String> getCurrentUserPrivateKey();
}
import 'package:domain/core/enum.dart';
import 'package:domain/src/entities/google_account.dart';

abstract interface class Web3AuthRepository {
  Future<GoogleAccount?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  });

  Future<void> logout();

  Future<String> getCurrentUserPrivateKey();
}

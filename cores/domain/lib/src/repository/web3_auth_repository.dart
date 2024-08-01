import 'package:domain/core/enum.dart';
import 'package:domain/src/entities/web3_auth_info.dart';

abstract interface class Web3AuthRepository {
  Future<Web3AuthInfo?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  });

  Future<void> logout();

  Future<String> getCurrentUserPrivateKey();
}

import 'package:data/src/dto/web3_auth_info_dto.dart';
import 'package:domain/domain.dart';

abstract interface class Web3AuthProvider {

  Future<Web3AuthInfoDto?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  });

  Future<void> logout();

  Future<String> getCurrentUserPrivateKey();
}
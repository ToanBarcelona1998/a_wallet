import 'package:domain/core/enum.dart';
import 'package:domain/src/entities/web3_auth_info.dart';
import 'package:domain/src/repository/web3_auth_repository.dart';

final class Web3AuthUseCase {
  final Web3AuthRepository _repository;

  const Web3AuthUseCase(this._repository);

  Future<Web3AuthInfo?> onLogin({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  })async{
    return await _repository.login(provider: provider);
  }

  Future<void> logout()async{
    return _repository.logout();
  }

  Future<String> getPrivateKey()async{
    return _repository.getCurrentUserPrivateKey();
  }
}
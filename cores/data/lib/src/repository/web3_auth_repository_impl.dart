import 'package:data/src/dto/web3_auth_info_dto.dart';
import 'package:data/src/resource/provider/web3_auth_provider.dart';
import 'package:domain/domain.dart';

class Web3AuthRepositoryImpl implements Web3AuthRepository {
  final Web3AuthProvider _web3AuthProvider;

  const Web3AuthRepositoryImpl(this._web3AuthProvider);


  @override
  Future<void> logout() async {
    return _web3AuthProvider.logout();
  }


  @override
  Future<String> getCurrentUserPrivateKey() {
    return _web3AuthProvider.getCurrentUserPrivateKey();
  }

  @override
  Future<Web3AuthInfo?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  }) async{
    final Web3AuthInfoDto? googleAccount =
        await _web3AuthProvider.login(provider: provider);

    return googleAccount?.toEntities;
  }
}

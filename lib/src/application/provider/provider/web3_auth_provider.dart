import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

extension Web3AuthLoginProviderMapper on Web3AuthLoginProvider{
  Provider get toWeb3AuthProvider => Provider.values[index];
}

class Web3AuthProviderImpl implements Web3AuthProvider {
  const Web3AuthProviderImpl();

  @override
  Future<String> getCurrentUserPrivateKey() async {
    return Web3AuthFlutter.getPrivKey();
  }

  @override
  Future<GoogleAccountDto?> login({
    Web3AuthLoginProvider provider = Web3AuthLoginProvider.google,
  }) async {
    final Web3AuthResponse response = await Web3AuthFlutter.login(
      LoginParams(
        /// maybe change later
        loginProvider: provider.toWeb3AuthProvider,
      ),
    );

    if (response.userInfo == null) return null;

    final userInfo = response.userInfo!;

    return GoogleAccountDto(
      idToken: userInfo.idToken ?? '',
      email: userInfo.email ?? '',
      name: userInfo.name,
      profileImage: userInfo.profileImage,
      oAuthIdToken: userInfo.oAuthIdToken,
      oAuthAccessToken: userInfo.oAuthAccessToken,
    );
  }

  @override
  Future<void> logout() async {
    return Web3AuthFlutter.logout();
  }
}

import 'package:domain/domain.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_core/wallet_core.dart';
import 'get_started_state.dart';

final class GetStartedCubit extends Cubit<GetStartedState> {
  final Web3AuthUseCase _web3authUseCase;

  GetStartedCubit(this._web3authUseCase)
      : super(
          const GetStartedState(),
        );

  /// Social login
  void onLogin(
    Web3AuthLoginProvider provider,
  ) async {
    try {
      emit(
        state.copyWith(
          status: GetStartedStatus.onSocialLogin,
        ),
      );

      // Login by web3 auth
      await _web3authUseCase.onLogin(
        provider: provider,
      );

      // Get current private key
      final String privateKey = await _web3authUseCase.getPrivateKey();

      // Import wallet by private key
      final AWallet aWallet =
          WalletCore.walletManagement.importWalletWithPrivateKey(
        privateKey,
        coinType: TWCoinType.TWCoinTypeEthereum,
      );

      // Expired current session
      await _web3authUseCase.logout();

      emit(
        state.copyWith(
          status: GetStartedStatus.loginSuccess,
          wallet: aWallet,
        ),
      );
    } catch (e) {
      String errMsg = e.toString();
      if (e is PlatformException) {
        errMsg = e.message ?? e.toString();
      }

      emit(
        state.copyWith(
          status: GetStartedStatus.loginFailure,
          error: errMsg,
        ),
      );
    }
  }
}

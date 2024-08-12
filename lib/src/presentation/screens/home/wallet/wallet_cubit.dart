import 'package:domain/domain.dart';
import 'package:flutter/services.dart';
import 'package:wallet_core/wallet_core.dart';

import 'wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class WalletCubit extends Cubit<WalletState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;
  final Web3AuthUseCase _web3authUseCase;

  WalletCubit(
      this._accountUseCase, this._keyStoreUseCase, this._web3authUseCase)
      : super(
          const WalletState(),
        ) {
    init();
  }

  void init() async {
    emit(
      state.copyWith(
        status: WalletStatus.loading,
      ),
    );
    try {
      final accounts = await _accountUseCase.getAll();

      emit(
        state.copyWith(
          accounts: accounts,
          status: WalletStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: WalletStatus.error,
        ),
      );
      LogProvider.log('Fetch wallet error ${e.toString()}');
    }
  }

  void refresh() async {
    return init();
  }

  void onAdd(
    String walletName,
    AWallet aWallet,
  ) async {
    try {
      final key = WalletCore.storedManagement.saveWallet(
        walletName,
        '',
        aWallet,
      );

      final keyStore = await _keyStoreUseCase.add(
        AddKeyStoreRequest(
          keyName: key ?? '',
        ),
      );

      final newAccount = await _accountUseCase.add(
        AddAccountRequest(
          index: 1,
          name: walletName,
          keyStoreId: keyStore.id,
          evmAddress: aWallet.address,
          type: AccountType.normal,
          controllerKeyType: ControllerKeyType.passPhrase,
          createType: AccountCreateType.normal,
        ),
      );

      emit(
        state.copyWith(accounts: [
          ...state.accounts,
          newAccount,
        ]),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: WalletStatus.error,
        ),
      );
      LogProvider.log('On add wallet error ${e.toString()}');
    }
  }

  void onSocialLogin(Web3AuthLoginProvider provider) async {
    try {
      final account = await _web3authUseCase.onLogin(
        provider: provider,
      );

      String privateKey = await _web3authUseCase.getPrivateKey();

      final aWallet =
          WalletCore.walletManagement.importWalletWithPrivateKey(privateKey);

      final String walletName = account?.name ?? account?.email ?? '';

      final String? key = WalletCore.storedManagement.saveWallet(
        walletName,
        '',
        aWallet,
      );

      final keyStore = await _keyStoreUseCase.add(
        AddKeyStoreRequest(
          keyName: key ?? '',
        ),
      );

      final aAccount = await _accountUseCase.add(
        AddAccountRequest(
          index: 1,
          name: walletName,
          keyStoreId: keyStore.id,
          evmAddress: aWallet.address,
          createType: AccountCreateType.social,
          type: AccountType.normal,
          controllerKeyType: ControllerKeyType.privateKey,
        ),
      );

      emit(
        state.copyWith(
          accounts: [
            ...state.accounts,
            aAccount,
          ],
        ),
      );
    } catch (e) {
      String errMsg = e.toString();
      if (e is PlatformException) {
        errMsg = e.message ?? e.toString();
      }

      emit(
        state.copyWith(
          status: WalletStatus.error,
          error: errMsg,
        ),
      );
      LogProvider.log('Wallet cubit on social login error $errMsg');
    }
  }

  AWallet createRandom() {
    final String mnemonic = WalletCore.walletManagement.randomMnemonic();
    return WalletCore.walletManagement.importWallet(
      mnemonic,
    );
  }
}

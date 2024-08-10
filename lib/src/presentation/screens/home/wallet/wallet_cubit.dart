import 'package:domain/domain.dart';
import 'package:wallet_core/wallet_core.dart';

import 'wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class WalletCubit extends Cubit<WalletState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;

  WalletCubit(this._accountUseCase, this._keyStoreUseCase)
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

  AWallet createRandom() {
    final String mnemonic = WalletCore.walletManagement.randomMnemonic();
    return WalletCore.walletManagement.importWallet(
      mnemonic,
    );
  }
}

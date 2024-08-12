import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_core/wallet_core.dart';
import 'signed_import_wallet_event.dart';
import 'signed_import_wallet_state.dart';

final class SignedImportWalletBloc
    extends Bloc<SignedImportWalletEvent, SignedImportWalletState> {
  final KeyStoreUseCase _keyStoreUseCase;
  final AccountUseCase _accountUseCase;

  SignedImportWalletBloc(this._accountUseCase, this._keyStoreUseCase)
      : super(
          const SignedImportWalletState(),
        ) {
    on(_onInit);
    on(_onChangeType);
    on(_onChangeWordCount);
    on(_onChangeControllerKey);
    on(_onSubmit);
    on(_onWalletNameChange);

    add(
      const SignedImportWalletOnInitEvent(),
    );
  }

  void _onInit(
    SignedImportWalletOnInitEvent event,
    Emitter<SignedImportWalletState> emit,
  ) async {
    try {
      final accounts = await _accountUseCase.getAll();

      emit(
        state.copyWith(
          accounts: accounts,
        ),
      );
    } catch (e) {
      LogProvider.log('Signed import wallet on init error ${e.toString()}');
    }
  }

  void _onChangeType(
    SignedImportWalletOnChangeTypeEvent event,
    Emitter<SignedImportWalletState> emit,
  ) {
    emit(
      state.copyWith(
        controllerType: event.type,
        controllerKey: '',
        status: SignedImportWalletStatus.none,
      ),
    );
  }

  void _onChangeWordCount(
    SignedImportWalletOnChangeWordCountEvent event,
    Emitter<SignedImportWalletState> emit,
  ) {
    emit(
      state.copyWith(
        wordCount: event.wordCount,
        controllerKey: '',
        status: SignedImportWalletStatus.none,
      ),
    );
  }

  void _onChangeControllerKey(
    SignedImportWalletOnControllerKeyChangeEvent event,
    Emitter<SignedImportWalletState> emit,
  ) {
    SignedImportWalletStatus status = state.status;

    if (isValidControllerKey(event.controllerKey) &&
        isValidWalletName(state.walletName)) {
      status = SignedImportWalletStatus.isReadySubmit;
    } else {
      status = SignedImportWalletStatus.none;
    }

    emit(
      state.copyWith(
        controllerKey: event.controllerKey,
        status: status,
      ),
    );
  }

  void _onSubmit(
    SignedImportWalletOnSubmitEvent event,
    Emitter<SignedImportWalletState> emit,
  ) async {
    emit(
      state.copyWith(status: SignedImportWalletStatus.importing),
    );

    AWallet wallet;

    switch (state.controllerType) {
      case ControllerKeyType.passPhrase:
        wallet = WalletCore.walletManagement.importWallet(
          state.controllerKey,
        );
        break;
      case ControllerKeyType.privateKey:
        wallet = WalletCore.walletManagement.importWalletWithPrivateKey(
          state.controllerKey,
        );
        break;
    }

    final key = WalletCore.storedManagement.saveWallet(
      state.walletName,
      '',
      wallet,
    );

    final keyStore = await _keyStoreUseCase.add(
      AddKeyStoreRequest(
        keyName: key ?? '',
      ),
    );

    await _accountUseCase.add(
      AddAccountRequest(
        index: 1,
        name: state.walletName,
        keyStoreId: keyStore.id,
        evmAddress: wallet.address,
        controllerKeyType: state.controllerType,
        type: AccountType.normal,
        createType: AccountCreateType.import,
      ),
    );

    // Apply multi derivation path to find out multi wallet address.
    await Future.delayed(
      const Duration(
        milliseconds: 1700,
      ),
    );

    emit(
      state.copyWith(
        status: SignedImportWalletStatus.imported,
      ),
    );
  }

  void _onWalletNameChange(
    SignedImportWalletOnWalletNameChangeEvent event,
    Emitter<SignedImportWalletState> emit,
  ) {
    SignedImportWalletStatus status = state.status;

    if (isValidControllerKey(state.controllerKey) &&
        isValidWalletName(event.walletName)) {
      status = SignedImportWalletStatus.isReadySubmit;
    } else {
      status = SignedImportWalletStatus.none;
    }
    emit(
      state.copyWith(
        walletName: event.walletName,
        status: status,
      ),
    );
  }

  bool isValidWalletName(String name) {
    if (name.isEmpty) return false;
    return state.accounts.firstWhereOrNull(
          (a) => a.name == name,
        ) ==
        null;
  }

  bool isValidControllerKey(String key) {
    try {
      switch (state.controllerType) {
        case ControllerKeyType.passPhrase:
          WalletCore.walletManagement.importWallet(
            key,
          );
          break;
        case ControllerKeyType.privateKey:
          WalletCore.walletManagement.importWalletWithPrivateKey(
            key,
          );
          break;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}

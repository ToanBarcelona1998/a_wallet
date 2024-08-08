import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_core/wallet_core.dart';
import 'import_wallet_event.dart';
import 'import_wallet_state.dart';

final class ImportWalletBloc
    extends Bloc<ImportWalletEvent, ImportWalletState> {
  ImportWalletBloc()
      : super(
          const ImportWalletState(),
        ) {
    on(_onChangeType);
    on(_onChangeWordCount);
    on(_onChangeControllerKey);
    on(_onSubmit);
  }

  void _onChangeType(
    ImportWalletOnChangeTypeEvent event,
    Emitter<ImportWalletState> emit,
  ) {
    emit(
      state.copyWith(
        controllerType: event.type,
        controllerKey: '',
        status: ImportWalletStatus.none,
      ),
    );
  }

  void _onChangeWordCount(
    ImportWalletOnChangeWordCountEvent event,
    Emitter<ImportWalletState> emit,
  ) {
    emit(
      state.copyWith(
        wordCount: event.wordCount,
        controllerKey: '',
        status: ImportWalletStatus.none,
      ),
    );
  }

  void _onChangeControllerKey(
    ImportWalletOnControllerKeyChangeEvent event,
    Emitter<ImportWalletState> emit,
  ) {
    ImportWalletStatus status = state.status;

    if (isValidControllerKey(event.controllerKey)) {
      status = ImportWalletStatus.isReadySubmit;
    } else {
      status = ImportWalletStatus.none;
    }

    emit(
      state.copyWith(
        controllerKey: event.controllerKey,
        status: status,
      ),
    );
  }

  void _onSubmit(
    ImportWalletOnSubmitEvent event,
    Emitter<ImportWalletState> emit,
  ) async {
    emit(
      state.copyWith(status: ImportWalletStatus.importing),
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

    // Apply multi derivation path to find out multi wallet address.
    await Future.delayed(
      const Duration(
        milliseconds: 1700,
      ),
    );

    emit(
      state.copyWith(
        status: ImportWalletStatus.imported,
        aWallet: wallet,
      ),
    );
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

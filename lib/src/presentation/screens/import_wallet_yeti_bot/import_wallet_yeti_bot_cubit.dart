import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/pyxis_account_constant.dart';
import 'package:wallet_core/wallet_core.dart';
import 'import_wallet_yeti_bot_state.dart';

final class ImportWalletYetiBotCubit extends Cubit<ImportWalletYetiBotState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;

  ImportWalletYetiBotCubit(
    this._accountUseCase,
    this._keyStoreUseCase, {
    required AWallet wallet,
  }) : super(
          ImportWalletYetiBotState(
            wallet: wallet,
          ),
        );

  void storeKey() async {
    emit(
      state.copyWith(
        status: ImportWalletYetiBotStatus.storing,
      ),
    );

    final String? key = WalletCore.storedManagement.saveWallet(
      PyxisAccountConstant.defaultNormalWalletName,
      '',
      state.wallet,
    );

    final keyStore = await _keyStoreUseCase.add(
      AddKeyStoreRequest(
        keyName: key!,
      ),
    );

    ControllerKeyType controllerKeyType = ControllerKeyType.passPhrase;

    if (state.wallet.wallet == null) {
      controllerKeyType = ControllerKeyType.privateKey;
    }

    await _accountUseCase.add(
      AddAccountRequest(
        name: PyxisAccountConstant.defaultNormalWalletName,
        evmAddress: state.wallet.address,
        type: AccountType.normal,
        keyStoreId: keyStore.id,
        controllerKeyType: controllerKeyType,
        createType: AccountCreateType.import,
        index: 0,
      ),
    );

    emit(
      state.copyWith(
        status: ImportWalletYetiBotStatus.stored,
      ),
    );
  }

  void updateStatus(bool isReady) {
    emit(
      state.copyWith(
        isReady: isReady,
      ),
    );
  }
}

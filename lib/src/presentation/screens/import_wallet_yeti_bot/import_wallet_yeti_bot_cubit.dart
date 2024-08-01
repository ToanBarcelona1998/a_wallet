import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/pyxis_account_constant.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:wallet_core/wallet_core.dart';
import 'import_wallet_yeti_bot_state.dart';

final class ImportWalletYetiBotCubit extends Cubit<ImportWalletYetiBotState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;

  ImportWalletYetiBotCubit(
    this._accountUseCase,
    this._keyStoreUseCase, {
    required AWallet wallet,
    required AppNetwork appNetwork,
  }) : super(
          ImportWalletYetiBotState(
            wallet: wallet,
            appNetwork: appNetwork,
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

    late AddACosmosInfoRequest addACosmosInfoRequest;
    late AddAEvmInfoRequest addAEvmInfoRequest;

    final String auraCosmosAddress = state.appNetwork.type.getAuraCosmosAddressByCreateType(state.wallet.address);
    final String auraEvmAddress = state.appNetwork.type.getAuraEvmAddressByCreateType(state.wallet.address);

    switch (state.appNetwork.type) {
      case AppNetworkType.cosmos:
        addACosmosInfoRequest = AddACosmosInfoRequest(
          address: auraCosmosAddress,
          isActive: true,
        );
        addAEvmInfoRequest = AddAEvmInfoRequest(
          address: auraEvmAddress,
          isActive: false,
        );
        break;
      case AppNetworkType.evm:
        addACosmosInfoRequest = AddACosmosInfoRequest(
          address: auraCosmosAddress,
          isActive: false,
        );
        addAEvmInfoRequest = AddAEvmInfoRequest(
          address: auraEvmAddress,
          isActive: true,
        );
        break;
      case AppNetworkType.other:
        throw UnimplementedError('Pick wallet does not support other network for this version');
    }

    await _accountUseCase.add(
      AddAccountRequest(
        name: PyxisAccountConstant.defaultNormalWalletName,
        addACosmosInfoRequest: addACosmosInfoRequest,
        addAEvmInfoRequest: addAEvmInfoRequest,
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

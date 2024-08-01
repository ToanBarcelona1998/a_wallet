import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/pyxis_account_constant.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:wallet_core/wallet_core.dart';
import 'social_login_yeti_bot_state.dart';

final class SocialLoginYetiBotCubit extends Cubit<SocialLoginYetiBotState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;

  SocialLoginYetiBotCubit(
    this._accountUseCase,
    this._keyStoreUseCase, {
    required AWallet wallet,
  }) : super(
          SocialLoginYetiBotState(
            wallet: wallet,
          ),
        );

  void storeKey() async {
    emit(
      state.copyWith(
        status: SocialLoginYetiBotStatus.storing,
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

    if(state.wallet.wallet == null){
      controllerKeyType = ControllerKeyType.privateKey;
    }

    final String evmAddress = state.wallet.address;

    final String cosmosAddress = AppNetworkType.evm.getAuraCosmosAddressByCreateType(evmAddress);

    await _accountUseCase.add(
      AddAccountRequest(
        name: PyxisAccountConstant.defaultNormalWalletName,
        addACosmosInfoRequest: AddACosmosInfoRequest(
          address: cosmosAddress,
          isActive: false,
        ),
        addAEvmInfoRequest: AddAEvmInfoRequest(
          address: evmAddress,
          isActive: true,
        ),
        keyStoreId: keyStore.id,
        controllerKeyType: controllerKeyType,
        createType: AccountCreateType.social,
        index: 0,
      ),
    );

    emit(
      state.copyWith(
        status: SocialLoginYetiBotStatus.stored,
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

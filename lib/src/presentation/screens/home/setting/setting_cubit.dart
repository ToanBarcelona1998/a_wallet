import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:domain/domain.dart';

import 'setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SettingCubit extends Cubit<SettingState> {
  final AccountUseCase _accountUseCase;
  final KeyStoreUseCase _keyStoreUseCase;
  final TokenUseCase _tokenUseCase;
  final AddressBookUseCase _addressBookUseCase;
  final BookMarkUseCase _bookMarkUseCase;
  final BrowserManagementUseCase _browserManagementUseCase;
  final BalanceUseCase _balanceUseCase;

  SettingCubit(
    this._accountUseCase,
    this._keyStoreUseCase,
    this._tokenUseCase,
    this._bookMarkUseCase,
    this._browserManagementUseCase,
    this._addressBookUseCase,
    this._balanceUseCase,
  ) : super(
          SettingState(
            currentLanguage:
                AppLocalizationManager.instance.getAppLocale().languageCode,
            languages: AppLocalizationManager.instance.supportedLang,
          ),
        );

  void onLogout() async {
    emit(
      state.copyWith(
        status: SettingStatus.onLogout,
      ),
    );

    final future = Future.any([
      _accountUseCase.deleteAll(),
      _keyStoreUseCase.deleteAll(),
      _tokenUseCase.deleteAll(),
      _balanceUseCase.deleteAll(),
      _browserManagementUseCase.deleteAll(),
      _addressBookUseCase.deleteAll(),
      _bookMarkUseCase.deleteAll(),
    ]);

    await future;

    emit(
      state.copyWith(
        status: SettingStatus.logoutDone,
      ),
    );
  }

  void onChangeLanguage(String code) async{
    AppLocalizationManager.instance.updateDeviceLocale(code);

    emit(
      state.copyWith(
        currentLanguage: code,
      ),
    );
  }
}

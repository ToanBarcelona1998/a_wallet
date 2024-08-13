import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'dart:ui' as ui;

class AppLocalizationManager {
  final LocalizationUseCase _localizationUseCase =
      getIt.get<LocalizationUseCase>();

  ///region create instance
  /// Create lazy singleton -- instance of [AppLocalizationManager]
  static AppLocalizationManager? _appLocalizationManager;

  AppLocalizationManager._init();

  factory AppLocalizationManager() {
    _appLocalizationManager ??= AppLocalizationManager._init();
    return _appLocalizationManager!;
  }

  static AppLocalizationManager get instance => AppLocalizationManager();

  static AppLocalizationManager of(BuildContext context) =>
      Localizations.of(context, AppLocalizationManager);

  ///endregion

  ///region localization map
  final Map<String, Map<String, String>> _supportedLocale = {};

  Locale _locale = const Locale('en');

  Map<String, String> get _currentLocalize =>
      _supportedLocale[_locale.languageCode] ?? <String, String>{};

  ///endregion

  Locale getAppLocale() {
    return _locale;
  }

  bool isSupportLocale(Locale locale) {
    return _supportedLocale.containsKey(locale.languageCode);
  }

  void setCurrentLocale(String localeCode) {
    if (_supportedLocale.containsKey(localeCode)) {
      _locale = Locale(localeCode);
    }else{
      _locale = const Locale('en');
    }
  }

  List<String> get supportedLang =>
      _supportedLocale.entries.map((e) => e.key).toList();

  ///
  /// Load all support locale and get user selected locale
  ///
  Future<void> load() async {
    /// Load all support locale
    List<String> supportLocales = await _localizationUseCase.getSupportLocale();
    for (String locale in supportLocales) {
      _supportedLocale[locale] = await _localizationUseCase.getLocalLanguage(
        locale: locale,
      );
    }

    /// Get user setting selected locale
    String? userSelectedLocale = await _localizationUseCase.getSelectedLocale();

    /// Check if user selected locale is not null
    if (userSelectedLocale != null) {
      setCurrentLocale(userSelectedLocale);
    }else{
      Locale systemLocale = ui.PlatformDispatcher.instance.locale;
      await updateDeviceLocale(systemLocale.languageCode);
    }
  }

  ///
  /// Load selected locale from device setting
  ///
  Future<void> updateDeviceLocale(String deviceLocale) async {
    setCurrentLocale(deviceLocale);
    await _localizationUseCase.saveSelectedLocale(
      locale: deviceLocale,
    );
  }

  ///region translate
  String translate(String key) {
    return _currentLocalize[key] ?? key;
  }

  String translateWithParam(String key, Map<String, dynamic> param) {
    if (_currentLocalize[key] != null) {
      String currentValue = _currentLocalize[key]!;

      param.forEach((paramKey, paramValue) {
        currentValue = currentValue.replaceFirst(
          '\${$paramKey}',
          paramValue.toString(),
        );
      });
      return currentValue;
    }

    return key;
  }

  ///endregion fu
}

import 'dart:convert';

import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:data/data.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalizationServiceImpl implements LocalizationService {
  final  SharedPreferences _storage;

  const LocalizationServiceImpl(this._storage);

  @override
  Future<Map<String, String>> getLocalLanguage({
    required String locale,
  }) async {
    String loader;
    try {
      loader = await rootBundle.loadString(
        AssetLanguagePath.localizationFullPath(locale),
      );
    } catch (e) {
      loader = await rootBundle
          .loadString(AssetLanguagePath.defaultLocalizationFullPath);
    }

    return Map<String, String>.from(jsonDecode(loader) as Map<String, dynamic>);
  }

  @override
  Future<List<String>> getSupportLocale() async {
    return [
      'vi',
      'en',
    ];
  }

  @override
  Future<String?> getSelectedLocale() async{
    return _storage.getString('AWalletLanguage');
  }

  @override
  void saveSelectedLocale({
    required String locale,
  }) async{
    await _storage.setString('AWalletLanguage', locale);
  }
}

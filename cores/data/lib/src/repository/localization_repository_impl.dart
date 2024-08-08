import 'package:data/src/resource/local/localization_service.dart';
import 'package:domain/domain.dart';

final class LocalizationRepositoryImpl implements LocalizationRepository {
  final LocalizationService _localizationService;

  LocalizationRepositoryImpl(this._localizationService);

  @override
  Future<Map<String, String>> getLocalLanguage({required String locale}) {
    return _localizationService.getLocalLanguage(locale: locale);
  }

  @override
  Future<Map<String, String>> getRemoteLanguage({
    required String locale,
  }) async {
    throw UnimplementedError('getRemoteLanguage() don\'t be supported');
  }

  @override
  Future<List<String>> getSupportLocale() async {
    return _localizationService.getSupportLocale();
  }

  @override
  Future<String?> getSelectedLocale() async {
    return _localizationService.getSelectedLocale();
  }

  @override
  void saveSelectedLocale({required String locale}) async {
    _localizationService.saveSelectedLocale(locale: locale);
  }
}

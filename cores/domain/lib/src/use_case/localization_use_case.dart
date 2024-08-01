import 'package:domain/src/repository/localization_repository.dart';

final class LocalizationUseCase {
  final LocalizationRepository _repository;

  const LocalizationUseCase(this._repository);

  Future<String?> getSelectedLocale() async {
    return _repository.getSelectedLocale();
  }

  /// Save Selected Locale
  Future<void> saveSelectedLocale({
    required String locale,
  }) async {
    return _repository.saveSelectedLocale(
      locale: locale,
    );
  }

  ///
  /// Lấy ra danh sách ngôn ngữ được hỗ trợ
  ///
  Future<List<String>> getSupportLocale() async {
    return _repository.getSupportLocale();
  }

  ///
  /// Đọc file Lang.json ra để lấy dữ liệu ngôn ngữ
  ///
  Future<Map<String, String>> getLocalLanguage({
    required String locale,
  }) async {
    return _repository.getLocalLanguage(
      locale: locale,
    );
  }

  ///
  /// Đọc file Lang.json từ remote ( tạm thời chưa dùng tới )
  ///
  Future<Map<String, String>> getRemoteLanguage({
    required String locale,
  }) async {
    return _repository.getRemoteLanguage(
      locale: locale,
    );
  }
}

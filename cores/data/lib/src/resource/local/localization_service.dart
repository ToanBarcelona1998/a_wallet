abstract interface class LocalizationService {
  Future<List<String>> getSupportLocale();

  Future<Map<String, String>> getLocalLanguage({
    required String locale,
  });

  Future<String?> getSelectedLocale();

  void saveSelectedLocale({required String locale});
}

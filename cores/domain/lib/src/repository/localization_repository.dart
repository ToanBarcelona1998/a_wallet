abstract interface class LocalizationRepository {
  Future<List<String>> getSupportLocale();

  Future<Map<String, String>> getRemoteLanguage({
    required String locale,
  });

  Future<Map<String, String>> getLocalLanguage({
    required String locale,
  });

  Future<String?> getSelectedLocale();

  saveSelectedLocale({required String locale});
}

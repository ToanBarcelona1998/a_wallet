abstract class LogProvider {
  LogProvider._();
  static LogProvider? _instance;

  static init(LogProvider instance) {
    _instance = instance;
  }

  static void log(String message) {
    if (_instance == null) {
      throw Exception('LogProvider is not initialized');
    }
    _instance?.printLog(message);
  }

  void printLog(String message);
}

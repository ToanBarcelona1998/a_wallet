class AppError {
  final String code;
  final String? error;

  const AppError({
    required this.code,
    this.error,
  });

  @override
  String toString() {
    return '[$code]: ${error ?? ''}';
  }
}

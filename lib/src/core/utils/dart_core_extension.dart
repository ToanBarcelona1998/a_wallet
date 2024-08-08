import 'dart:math';

extension StringExtensions on String? {
  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    if (this!.isEmpty) {
      return true;
    }
    return false;
  }

  bool get isNotNullOrEmpty => !isEmptyOrNull;

  String subStringOr(int start, int end) {
    if (isEmptyOrNull) return '';

    if (this!.length < end) return this!;

    return this!.substring(start, end);
  }
}

extension ListExtensions<T> on List<T>? {
  bool get isNullOrEmpty {
    if (this == null) return true;

    if (this!.isEmpty) return true;

    return false;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  T? get firstOrNull {
    if (isNotNullOrEmpty) return this!.first;
    return null;
  }

  T? firstWhereOrNull(bool Function(T) test) {
    if (isNullOrEmpty) return null;

    for (final e in this!) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }

  bool isNotNull(int index) {
    if (isNullOrEmpty) return false;

    if (index < 0) return false;

    return true;
  }

  T? lastWhereOrNull(bool Function(T) test) {
    if (isNullOrEmpty) return null;

    List<T> list = List.empty(growable: true);

    for (final e in this!) {
      if (test(e)) {
        list.add(e);
      }
    }

    if (list.isNullOrEmpty) return null;

    return list.last;
  }

  bool constantIndex(int i) {
    if (isNullOrEmpty) return false;

    if (i < 0) return false;

    if (i > this!.length - 1) {
      return false;
    }

    return true;
  }

  T ?getIndex(int i){
    if(constantIndex(i)){
      return this![i];
    }

    return null;
  }
}

extension IntExtension on int {
  String get toHours {
    int h = this ~/ 3600;

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    return hourLeft;
  }

  String get toMinutes {
    int h = this ~/ 3600;

    int m = ((this - h * 3600)) ~/ 60;

    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    return minuteLeft;
  }

  String get toSeconds {
    int h = this ~/ 3600;

    int m = ((this - h * 3600)) ~/ 60;

    int s = this - (h * 3600) - (m * 60);

    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();
    return secondsLeft;
  }

}

extension TruncateDoubles on double {
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}

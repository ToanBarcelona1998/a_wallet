import 'dart:typed_data';

extension BigIntE on BigInt {
  Uint8List toUin8List() {
    final byteMask = BigInt.from(0xff);
    var number = this;
    final size = (number.bitLength + 7) >> 3;
    final result = Uint8List(size);

    for (var i = 0; i < size; i++) {
      result[size - i - 1] = (number & byteMask).toInt();
      number = number >> 8;
    }
    return result;
  }
}

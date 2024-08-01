import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
sealed class CryptoHelper{
  static String hashStringBySha256(String value){
    final Digest digest = _hashStringToDigest(value);

    return digest.toString();
  }

  static Uint8List hashStringToByteBySha256(String value){
    final Digest digest = _hashStringToDigest(value);

    return Uint8List.fromList(digest.bytes);
  }

  static Digest _hashStringToDigest(String value){
    final Uint8List bytes = utf8.encode(value);

    return sha256.convert(bytes);
  }
}
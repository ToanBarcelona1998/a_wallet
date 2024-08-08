import 'dart:typed_data';

import 'package:bech32/bech32.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';

String cosmosToEthAddress(String cosmosAddress) {
  // Decode the Bech32 Cosmos address
  var bech32Codec = const Bech32Codec();
  var decoded = bech32Codec.decode(cosmosAddress);

  // Convert from 5-bit to 8-bit array
  var data = convertBits(decoded.data, 5, 8, false);
  if (data == null) {
    throw Exception('Failed to convert bits.');
  }

  // Extract the public key (assumes standard length)
  var publicKey = Uint8List.fromList(data.sublist(0, data.length - 1));

  // Compute the Keccak-256 hash of the public key
  var ethAddressBytes = keccak256(publicKey.sublist(1)).sublist(12);

  // Convert to a checksum address
  var ethAddress = bytesToHex(ethAddressBytes, include0x: true);
  return ethAddress;
}

List<int>? convertBits(List<int> data, int from, int to, bool pad) {
  int acc = 0;
  int bits = 0;
  final maxv = (1 << to) - 1;
  final ret = <int>[];
  for (final value in data) {
    if (value < 0 || (value >> from) != 0) {
      return null;
    }
    acc = (acc << from) | value;
    bits += from;
    while (bits >= to) {
      bits -= to;
      ret.add((acc >> bits) & maxv);
    }
  }
  if (pad) {
    if (bits > 0) {
      ret.add((acc << (to - bits)) & maxv);
    }
  } else if (bits >= from || ((acc << (to - bits)) & maxv) != 0) {
    return null;
  }
  return ret;
}

void main() {
  var cosmosAddress = "cosmos1y9y4vajtazvnm8purz27u3037478vvcnpnhha4";
  var ethAddress = cosmosToEthAddress(cosmosAddress);
  print('Ethereum Address: $ethAddress');
}

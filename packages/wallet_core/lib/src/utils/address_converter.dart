import 'package:bech32/bech32.dart';
import 'package:web3dart/crypto.dart' as evmCrypto;

export 'package:bech32/bech32.dart';

extension Bech32Extension on List<int> {
  List<int> toBech32Words() {
    final words = <int>[];
    int accumulator = 0;
    int bits = 0;

    for (var byte in this) {
      accumulator = (accumulator << 8) | byte;
      bits += 8;

      while (bits >= 5) {
        bits -= 5;
        words.add((accumulator >> bits) & 0x1f);
      }
    }

    if (bits > 0) {
      words.add((accumulator << (5 - bits)) & 0x1f);
    }

    return words;
  }

  List<int> fromBech32Words() {
    final data = <int>[];
    int accumulator = 0;
    int bits = 0;

    for (var word in this) {
      accumulator = (accumulator << 5) | word;
      bits += 5;

      while (bits >= 8) {
        bits -= 8;
        data.add((accumulator >> bits) & 0xff);
      }
    }

    return data;
  }

  String bytesToHex({bool include0x = false}) {
    final buffer = StringBuffer();
    if (include0x) buffer.write('0x');
    for (var part in this) {
      buffer.write(part.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}

extension Bech32CodeSpecExtension on Bech32Codec {
  // Bech32 encoding function
  String makeBech32Encoder(String prefix, List<int> data) {
    final bech32Data = Bech32(
      prefix,
      data.toBech32Words(),
    );
    return bech32.encode(bech32Data);
  }

// Bech32 decoding function
  List<int> makeBech32Decoder(String currentPrefix, String input) {
    final decoded = bech32.decode(input);

    if (decoded.hrp != currentPrefix) {
      throw Exception('Unrecognised address format');
    }
    return decoded.data.fromBech32Words();
  }

  // Convert Bech32 address to Ethereum address
  String convertBech32AddressToEthAddress(String prefix, String bech32Address) {
    final data = makeBech32Decoder(prefix, bech32Address);

    final ethAddress = data.sublist(data.length - 20);
    return ethAddress.bytesToHex(include0x: true);
  }

// Convert Ethereum address to Bech32 address
  String convertEthAddressToBech32Address(String prefix, String ethAddress) {
    final ethData = evmCrypto.hexToBytes(ethAddress);
    return makeBech32Encoder(prefix, ethData);
  }
}

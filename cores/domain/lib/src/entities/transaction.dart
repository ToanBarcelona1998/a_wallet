final class Transaction {
  final String? data;
  final String hash;
  final String value;
  final int height;
  final String to;
  final String from;
  final Tx tx;

  const Transaction({
    required this.tx,
    required this.from,
    required this.to,
    required this.value,
    this.data,
    required this.hash,
    required this.height,
  });
}

final class Tx {
  final String time;

  const Tx({
    required this.time,
  });
}

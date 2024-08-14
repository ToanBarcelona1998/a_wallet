import 'package:domain/domain.dart';

extension TransactionDtoMapper on TransactionDto {
  Transaction get toEntity => Transaction(
        tx: tx.toEntity,
        from: from,
        to: to,
        value: value,
        hash: hash,
        height: height,
        data: data,
      );
}

extension TxDtoMapper on TxDto {
  Tx get toEntity => Tx(
        time: time,
      );
}

final class TransactionDto {
  final String? data;
  final String hash;
  final String value;
  final int height;
  final String to;
  final String from;
  final TxDto tx;

  const TransactionDto({
    required this.tx,
    required this.from,
    required this.to,
    required this.value,
    this.data,
    required this.hash,
    required this.height,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      tx: TxDto.fromJson(
        json['transaction'],
      ),
      from: json['from'],
      to: json['to'],
      value: json['value'],
      hash: json['hash'],
      height: json['height'],
      data: json['data'],
    );
  }
}

final class TxDto {
  final String time;

  const TxDto({
    required this.time,
  });

  factory TxDto.fromJson(Map<String, dynamic> json) {
    return TxDto(
      time: json['timestamp'],
    );
  }
}

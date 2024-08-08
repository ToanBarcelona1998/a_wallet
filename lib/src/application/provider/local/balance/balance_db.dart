import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'balance_db.g.dart';

extension AddAccountBalanceRequestDtoMapper on AddAccountBalanceRequestDto {
  AccountBalanceDb get mapRequestToDb => AccountBalanceDb(
        accountId: accountId,
        balances: balances
            .map(
              (e) => e.mapRequestToDb,
            )
            .toList(),
      );
}

extension AddBalanceRequestDtoMapper on AddBalanceRequestDto {
  BalanceDb get mapRequestToDb => BalanceDb(
        balance: balance,
        tokenId: tokenId,
      );
}

extension AccountBalanceDbExtension on AccountBalanceDb {
  AccountBalanceDb copyWith({
    int? id,
    List<BalanceDb>? balances,
  }) {
    return AccountBalanceDb(
      id: id ?? this.id,
      accountId: accountId,
      balances: balances ?? this.balances,
    );
  }

  AccountBalanceDto get toDto => AccountBalanceDto(
        id: id,
        accountId: accountId,
        balances: balances
            .map(
              (e) => e.toDto,
            )
            .toList(),
      );
}

extension BalanceDbExtension on BalanceDb {
  BalanceDb copyWith({
    int? tokenId,
    String? balance,
  }) {
    return BalanceDb(
      tokenId: tokenId ?? this.tokenId,
      balance: balance ?? this.balance,
    );
  }

  BalanceDto get toDto => BalanceDto(
        balance: balance,
        tokenId: tokenId,
      );
}

@Collection(inheritance: false)
class AccountBalanceDb {
  final Id id;
  final int accountId;
  final List<BalanceDb> balances;

  const AccountBalanceDb({
    this.id = Isar.autoIncrement,
    required this.accountId,
    required this.balances,
  });
}

@embedded
class BalanceDb {
  final String balance;
  final int tokenId;

  const BalanceDb({
    this.balance = '0',
    this.tokenId = -9999,
  });
}

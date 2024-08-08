import 'package:isar/isar.dart';
import 'package:a_wallet/src/application/provider/local/account/account_db.dart';
import 'package:a_wallet/src/application/provider/local/balance/balance_db.dart';
import 'package:a_wallet/src/application/provider/local/key_store/key_store_db.dart';
import 'package:a_wallet/src/application/provider/local/token_market/token_market_db.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';

Future<Isar> getIsar() async {
  late Isar isar;
  if (Isar.instanceNames.isEmpty) {
    isar = await Isar.open(
      [
        AccountDbSchema,
        KeyStoreDbSchema,
        AccountBalanceDbSchema,
        TokenMarketDbSchema,
      ],
      directory: '',
      name: AppLocalConstant.localDbName,
      maxSizeMiB: 128,
    );
  } else {
    isar = Isar.getInstance(
      AppLocalConstant.localDbName,
    )!;
  }

  return isar;
}
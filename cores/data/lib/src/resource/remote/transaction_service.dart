import 'package:data/core/base_response.dart';

abstract interface class TransactionService {
  Future<XWalletBaseResponseV2> queryTxAccount(
    Map<String, dynamic> body,
  );

  Future<XWalletBaseResponseV2> queryFunctionMapping(
    Map<String, dynamic> body,
  );
}

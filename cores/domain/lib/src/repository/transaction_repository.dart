import 'package:domain/src/entities/function_mapping.dart';
import 'package:domain/src/entities/request/query_function_mapping_request.dart';
import 'package:domain/src/entities/request/query_transaction_request.dart';
import 'package:domain/src/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<List<Transaction>> queryTxAccount(
    QueryTransactionRequest request,
  );

  Future<List<FunctionMapping>> queryFunctionMapping(
    QueryFunctionMappingRequest request,
  );
}

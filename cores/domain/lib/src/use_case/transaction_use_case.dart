import 'package:domain/src/entities/function_mapping.dart';
import 'package:domain/src/entities/request/query_function_mapping_request.dart';
import 'package:domain/src/entities/request/query_transaction_request.dart';
import 'package:domain/src/entities/transaction.dart';
import 'package:domain/src/repository/transaction_repository.dart';

final class TransactionUseCase {
  final TransactionRepository _transactionRepository;

  const TransactionUseCase(this._transactionRepository);

  Future<List<FunctionMapping>> queryFunctionMapping(QueryFunctionMappingRequest request){
    return _transactionRepository.queryFunctionMapping(request);
  }

  Future<List<Transaction>> queryAccountTransaction(QueryTransactionRequest request){
    return _transactionRepository.queryTxAccount(request);
  }
}
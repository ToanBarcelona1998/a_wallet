import 'package:data/src/dto/function_mapping_dto.dart';
import 'package:data/src/dto/request/query_function_mapping_request_dto.dart';
import 'package:data/src/dto/request/query_transaction_request_dto.dart';
import 'package:data/src/dto/transaction_dto.dart';
import 'package:data/src/resource/remote/transaction_service.dart';
import 'package:domain/domain.dart';

final class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _transactionService;

  const TransactionRepositoryImpl(this._transactionService);

  @override
  Future<List<FunctionMapping>> queryFunctionMapping(
      QueryFunctionMappingRequest request) async {
    final QueryFunctionMappingRequestDto requestDto = request.mapRequest;

    final baseResponse = await _transactionService.queryFunctionMapping(
      requestDto.toMap(),
    );

    final data = baseResponse.handleResponse();

    final List<FunctionMappingDto> functions = List.empty(growable: true);

    for (final map in data[requestDto.environment]['evm_signature_mapping']) {
      final FunctionMappingDto functionMappingDto =
          FunctionMappingDto.fromJson(map);

      functions.add(functionMappingDto);
    }

    return functions
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }

  @override
  Future<List<Transaction>> queryTxAccount(
      QueryTransactionRequest request) async {
    final QueryTransactionRequestDto requestDto = request.mapRequest;

    final baseResponse = await _transactionService.queryTxAccount(
      requestDto.toMap(),
    );

    final data = baseResponse.handleResponse();

    final List<TransactionDto> transactions = List.empty(growable: true);

    for (final map in data[requestDto.environment]['evm_transaction']) {
      final TransactionDto transactionDto =
      TransactionDto.fromJson(map);

      transactions.add(transactionDto);
    }

    return transactions
        .map(
          (e) => e.toEntity,
    )
        .toList();
  }
}

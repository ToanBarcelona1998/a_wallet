import 'package:a_wallet/src/application/provider/service/api_service_path.dart';
import 'package:data/core/base_response.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'transaction_service_impl.g.dart';

final class TransactionServiceImpl implements TransactionService {

  final TransactionServiceGenerator _transactionServiceGenerator;

  const TransactionServiceImpl(this._transactionServiceGenerator);

  @override
  Future<XWalletBaseResponseV2> queryFunctionMapping(
      Map<String, dynamic> body) {
    return _transactionServiceGenerator.queryFunctionMapping(body);
  }

  @override
  Future<XWalletBaseResponseV2> queryTxAccount(Map<String, dynamic> body) {
    return _transactionServiceGenerator.queryTxAccount(body);
  }
}

@RestApi()
abstract class TransactionServiceGenerator {
  factory TransactionServiceGenerator(
    Dio dio, {
    String? baseUrl,
  }) = _TransactionServiceGenerator;

  @POST(ApiServicePath.graphiql)
  Future<XWalletBaseResponseV2> queryFunctionMapping(@Body() Map<String,dynamic> body);

  @POST(ApiServicePath.graphiql)
  Future<XWalletBaseResponseV2> queryTxAccount(@Body() Map<String,dynamic> body);
}

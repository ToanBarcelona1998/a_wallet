import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:isar/isar.dart';
import 'package:a_wallet/src/application/provider/local/token_market/token_market_database_service_impl.dart';
import 'package:a_wallet/src/application/provider/service/token_market/remote_token_market_service_impl.dart';

TokenMarketUseCase tokenMarketFactory(Dio dio, Isar isar) {
  return TokenMarketUseCase(
    TokenMarketRepositoryImpl(
      RemoteTokenMarketServiceImpl(
        RemoteTokenMarketServiceGenerator(dio),
      ),
      TokenMarketDatabaseServiceImpl(isar),
    ),
  );
}

import 'package:data/src/dto/balance_dto.dart';
import 'package:data/src/dto/request/add_balance_request_dto.dart';
import 'package:data/src/dto/request/query_balance_request_dto.dart';
import 'package:data/src/resource/local/balance_database_service.dart';
import 'package:data/src/resource/remote/balance_service.dart';
import 'package:domain/domain.dart';

final class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceDatabaseService _balanceDatabaseService;
  final BalanceService _balanceService;

  const BalanceRepositoryImpl(
      this._balanceService, this._balanceDatabaseService);

  @override
  Future<AccountBalance> add<P>(P param) async {
    final balanceDto = await _balanceDatabaseService.add(
      (param as AddAccountBalanceRequest).mapRequest,
    );

    return balanceDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _balanceDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _balanceDatabaseService.deleteAll();
  }

  @override
  Future<AccountBalance?> get(int id) async {
    final balanceDto = await _balanceDatabaseService.get(id);

    return balanceDto?.toEntity;
  }

  @override
  Future<List<AccountBalance>> getAll() async {
    final balancesDto = await _balanceDatabaseService.getAll();

    return balancesDto
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }

  @override
  Future<AccountBalance> update<P>(P param) async {
    throw UnimplementedError();
  }

  @override
  Future<AccountBalance?> getByAccountID({required int accountId}) async {
    final accountBalance =
        await _balanceDatabaseService.getByAccountID(accountId: accountId);

    return accountBalance?.toEntity;
  }

  @override
  Future<String> getNativeBalance({required String address}) {
    return _balanceService.getNativeBalance(address: address);
  }

  @override
  Future<List<Erc20TokenBalance>> getErc20Balance(
    QueryBalanceRequest request,
  ) async {
    final response = await _balanceService.getErc20Balance(
      body: (request as QueryERC20BalanceRequest).mapRequest.toMap(),
    );

    final data = response.handleResponse();

    final List<Erc20TokenBalanceDto> balances = [];

    final balanceMaps = data[request.environment]['account_balance'];

    for(final map in balanceMaps){
      final Erc20TokenBalanceDto balanceDto = Erc20TokenBalanceDto.fromJson(map);

      balances.add(balanceDto);
    }

    return balances
        .map(
          (e) => e.toEntity,
    )
        .toList();
  }
}

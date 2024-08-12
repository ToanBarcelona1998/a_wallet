import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/factory_creator/account_balance.dart';
import 'package:a_wallet/src/core/factory_creator/dio.dart';
import 'package:a_wallet/src/core/factory_creator/isar.dart';
import 'package:a_wallet/src/core/factory_creator/nft.dart';
import 'package:a_wallet/src/core/factory_creator/token_market.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:wallet_core/wallet_core.dart';

import 'home_page_event.dart';
import 'home_page_state.dart';

// Bloc for handling state management in the HomePage
final class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final TokenMarketUseCase _tokenMarketUseCase;
  final BalanceUseCase _balanceUseCase;
  final AccountUseCase _accountUseCase;
  final AWalletConfig config;
  final TokenUseCase _tokenUseCase;

// Constructor initializing use cases and setting up event handlers
  HomePageBloc(
    this._tokenUseCase,
    this._accountUseCase,
    this._tokenMarketUseCase,
    this._balanceUseCase, {
    required this.config,
  }) : super(
          const HomePageState(),
        ) {
    _initMultiThread();
    on(_loadStorageData);
    on(_onUpdateTokenMarket);
    on(_onUpdateAccountBalance);
    on(_onUpdateNFTs);
    on(_onChangeEnableToken);
    on(_onRefreshTokenBalance);
    on(_onChangeSelectedAccount);
  }

  // Isolates and SendPorts for handling concurrent tasks
  late Isolate _balanceIsolate;
  SendPort? _balanceSendPort;

  late Isolate _tokenIsolate;
  SendPort? _tokenSendPort;

  late Isolate _nftIsolate;
  SendPort? _nftSendPort;

  late ReceivePort _mainTokenReceivePort;
  late ReceivePort _mainBalanceReceivePort;
  late ReceivePort _mainNFTReceivePort;

  /// Initialize multiple threads (isolates) for different tasks
  void _initMultiThread() async {
    _mainTokenReceivePort = ReceivePort();
    _mainBalanceReceivePort = ReceivePort();
    _mainNFTReceivePort = ReceivePort();

    _tokenIsolate = await Isolate.spawn(
        _backgroundFetchTokenMarket, _mainTokenReceivePort.sendPort);

    _balanceIsolate = await Isolate.spawn(
        _backgroundFetchBalance, _mainBalanceReceivePort.sendPort);

    _nftIsolate =
        await Isolate.spawn(_backgroundFetchNFT, _mainNFTReceivePort.sendPort);

    // Listens for messages from the token thread
    _mainTokenReceivePort.listen(
      (message) {
        if (message is Map<String, dynamic>) {
          if (message.containsKey('token_market_port')) {
            // Receive SendPort from token thread
            _tokenSendPort = message['token_market_port'] as SendPort;

            // Fetch token market data
            _sendMessageFetchTokenMarket();
          } else if (message.containsKey('token_market')) {
            add(
              HomePageOnUpdateTokenMarketEvent(
                tokenMarkets: message['token_market'],
              ),
            );
          } else {
            LogProvider.log('fetch market token error ${message['error']}');
          }
        }
      },
    );

    // Listens for messages from the balance thread
    _mainBalanceReceivePort.listen(
      (message) {
        if (message is Map<String, dynamic>) {
          if (message.containsKey('balance_port')) {
            _balanceSendPort = message['balance_port'] as SendPort;
          } else if (message.containsKey('balanceMap')) {
            add(
              HomePageOnUpdateAccountBalanceEvent(
                balanceMap: message['balanceMap'],
              ),
            );
          } else {
            LogProvider.log('fetch balance error ${message['error']}');
          }
        }
      },
    );

    // Listens for messages from the NFT thread
    _mainNFTReceivePort.listen(
      (message) {
        if (message is Map<String, dynamic>) {
          if (message.containsKey('nft_port')) {
            _nftSendPort = message['nft_port'] as SendPort;

            add(
              const HomePageOnGetStorageDataEvent(),
            );
          } else if (message.containsKey('nftS')) {
            add(
              HomePageOnUpdateNFTsEvent(
                nftS: message['nftS'],
              ),
            );
          } else {
            LogProvider.log('fetch nft error ${message['error']}');
          }
        }
      },
    );
  }

  // Fetch token market data in a separate thread
  static void _backgroundFetchTokenMarket(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send({
      'token_market_port': receivePort.sendPort,
    });

    await for (final message in receivePort) {
      if (message is Map<String, dynamic>) {
        try {
          final String urlV1 = message['base_url_v1'];
          final Dio dio = dioFactory(urlV1);

          final Isar isar = await getIsar();

          final TokenMarketUseCase tokenMarketUseCase = tokenMarketFactory(
            dio,
            isar,
          );

          _fetchTokenMarket(
            tokenMarketUseCase,
            sendPort,
          );
        } catch (error) {
          // Send the error back to the main isolate
          sendPort.send({'error': error.toString()});
        }
      }
    }
  }

  // Fetch balance data in a separate thread
  static void _backgroundFetchBalance(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send({
      'balance_port': receivePort.sendPort,
    });

    await for (final message in receivePort) {
      if (message is Map<String, dynamic>) {
        try {
          final Isar isar = await getIsar();

          final Dio dio = dioFactory(
            message['base_url_v2'],
          );

          final BalanceUseCase balanceUseCase = balanceFactory(isar, dio);

          await _fetchBalance(
            balanceUseCase,
            sendPort,
            message,
          );
        } catch (error) {
          // Send the error back to the main isolate
          sendPort.send({'error': error.toString()});
        }
      }
    }
  }

  // Fetch NFT data in a separate thread
  static void _backgroundFetchNFT(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send({
      'nft_port': receivePort.sendPort,
    });

    await for (final message in receivePort) {
      if (message is Map<String, dynamic>) {
        try {
          final Dio dio = dioFactory(
            message['base_url_v2'],
          );

          final NftUseCase nftUseCase = nftUseCaseFactory(dio);

          await _fetchNFT(
            nftUseCase,
            sendPort,
            message,
          );
        } catch (error) {
          // Send the error back to the main isolate
          sendPort.send({'error': error.toString()});
        }
      }
    }
  }

  // Fetch token market data from the server
  static Future<void> _fetchTokenMarket(
    TokenMarketUseCase tokenMarketUseCase,
    SendPort sendPort,
  ) async {
    try {
      final tokenMarkets = await tokenMarketUseCase.getRemoteTokenMarket();

      sendPort.send({
        'token_market': tokenMarkets,
      });

      await tokenMarketUseCase.putAll(
        request: tokenMarkets
            .map(
              (e) => PutAllTokenMarketRequest(
                id: e.id,
                symbol: e.symbol,
                name: e.name,
                image: e.image,
                currentPrice: e.currentPrice,
                priceChangePercentage24h: e.priceChangePercentage24h,
                denom: e.denom,
                decimal: e.decimal,
              ),
            )
            .toList(),
      );
    } catch (e) {
      // Send the error back to the main isolate
      sendPort.send({'error': e.toString()});
    }
  }

  // Fetch balance data from the server
  static Future<void> _fetchBalance(
    BalanceUseCase balanceUseCase,
    SendPort sendPort,
    Map<String, dynamic> message,
  ) async {
    try {
      final Account account = message['account'];

      final String environment = message['environment'];

      Map<TokenType, dynamic> result = {};

      String amount = await balanceUseCase.getNativeBalance(
        address: account.evmAddress,
      );

      result[TokenType.native] = amount;

      final erc20TokenBalances = await balanceUseCase.getErc20TokenBalance(
        request: QueryERC20BalanceRequest(
          address: bech32.convertEthAddressToBech32Address(
            'aura',
            account.evmAddress,
          ),
          environment: environment,
        ),
      );

      result[TokenType.erc20] = erc20TokenBalances;

      sendPort.send({
        'balanceMap': result,
      });
    } catch (e) {
      // Send the error back to the main isolate
      sendPort.send({'error': e.toString()});
    }
  }

  // Fetch NFT data from the server
  static Future<void> _fetchNFT(
    NftUseCase nftUseCase,
    SendPort sendPort,
    Map<String, dynamic> message,
  ) async {
    try {
      final Account account = message['account'];

      final String environment = message['environment'];

      final List<NFTInformation> erc721s = await nftUseCase.queryNFTs(
        QueryERC721Request(
          owner: account.evmAddress.toLowerCase(),
          environment: environment,
          limit: 4,
        ),
      );

      sendPort.send({
        'nftS': erc721s,
      });
    } catch (e) {
      // Send the error back to the main isolate
      sendPort.send({'error': e.toString()});
    }
  }

  void _loadStorageData(
    HomePageOnGetStorageDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      final tokens = await _tokenUseCase.getAll();

      final activeAccount = await _accountUseCase.getFirstAccount();

      emit(
        state.copyWith(
          activeAccount: activeAccount,
          tokens: tokens,
        ),
      );

      _sendMessageFetchAccountBalance(activeAccount);

      _sendMessageFetchNFTs(activeAccount);

      final tokenMarkets = await _tokenMarketUseCase.getAll();

      emit(
        state.copyWith(
          tokenMarkets: tokenMarkets,
        ),
      );

      final accountBalance = await _balanceUseCase.getByAccountID(
        accountId: activeAccount!.id,
      );

      emit(
        state.copyWith(
          accountBalance: accountBalance,
          totalTokenValue: _calculateBalance(accountBalance)[0],
          totalValue: _calculateBalance(accountBalance)[0],
          totalValueYesterday: _calculateBalance(accountBalance)[1],
        ),
      );
    } catch (e) {
      LogProvider.log(e.toString());
    }
  }

  void _onUpdateTokenMarket(
    HomePageOnUpdateTokenMarketEvent event,
    Emitter<HomePageState> emit,
  ) {
    emit(
      state.copyWith(
        tokenMarkets: event.tokenMarkets,
      ),
    );
  }

  void _onUpdateAccountBalance(
    HomePageOnUpdateAccountBalanceEvent event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      List<AddBalanceRequest> requests = [];

      final nativeAmount = event.balanceMap[TokenType.native];
      if (nativeAmount != null) {
        Token? token = state.tokens.firstWhereOrNull(
          (token) => token.type == TokenType.native,
        );

        token ??= await _tokenUseCase.add(
          AddTokenRequest(
            logo: AppLocalConstant.auraLogo,
            tokenName: config.config.nativeCoin.name,
            type: TokenType.native,
            symbol: config.config.nativeCoin.symbol,
            contractAddress: '',
            isEnable: true,
          ),
        );

        requests.add(
          AddBalanceRequest(
            balance: nativeAmount,
            tokenId: token.id,
          ),
        );
      }

      final List<Erc20TokenBalance> ercTokenBalances =
          event.balanceMap[TokenType.erc20] ?? <Erc20TokenBalance>[];

      // Add erc token
      for (final erc in ercTokenBalances) {
        Token? token = state.tokens.firstWhereOrNull(
          (token) => token.contractAddress == erc.denom,
        );

        if (token == null) {
          final tokenMarket = state.tokenMarkets.firstWhereOrNull(
            (token) => token.denom == erc.denom,
          );

          token = await _tokenUseCase.add(
            AddTokenRequest(
              logo: tokenMarket?.image ?? AppLocalConstant.auraLogo,
              tokenName: tokenMarket?.name ?? '',
              type: TokenType.erc20,
              symbol: tokenMarket?.symbol ?? '',
              contractAddress: erc.denom,
              isEnable: true,
              decimal: tokenMarket?.decimal,
            ),
          );
        }

        requests.add(
          AddBalanceRequest(
            balance: erc.amount,
            tokenId: token.id,
          ),
        );
      }

      if (state.accountBalance != null) {
        await _balanceUseCase.delete(
          state.accountBalance!.id,
        );
      }

      final accountBalance = await _balanceUseCase.add(
        AddAccountBalanceRequest(
          accountId: state.activeAccount!.id,
          balances: requests,
        ),
      );

      final tokens = await _tokenUseCase.getAll();

      emit(
        state.copyWith(
          accountBalance: accountBalance,
          totalTokenValue: _calculateBalance(accountBalance)[0],
          totalValue: _calculateBalance(accountBalance)[0],
          totalValueYesterday: _calculateBalance(accountBalance)[1],
          tokens: tokens,
        ),
      );
    } catch (e) {
      LogProvider.log(e.toString());
    }
  }

  void _onUpdateNFTs(
    HomePageOnUpdateNFTsEvent event,
    Emitter<HomePageState> emit,
  ) {
    final List<NFTInformation> nftS = List.empty(growable: true);

    nftS.addAll(event.nftS);

    nftS.sort(
      (a, b) {
        return a.lastUpdatedHeight - b.lastUpdatedHeight;
      },
    );

    if (nftS.length >= 4) {
      emit(
        state.copyWith(
          nftS: nftS.getRange(0, 3).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          nftS: nftS,
        ),
      );
    }
  }

  void _onChangeEnableToken(HomePageOnUpdateEnableTotalTokenEvent event,
      Emitter<HomePageState> emit) {
    emit(state.copyWith(
      enableToken: !state.enableToken,
    ));
  }

  // Send a message to fetch token market data
  void _sendMessageFetchTokenMarket() {
    _tokenSendPort?.send({
      'base_url_v1': config.config.api.v1.url,
    });
  }

  // Send a message to fetch account balance data
  void _sendMessageFetchAccountBalance(Account? activeAccount) {
    _balanceSendPort?.send({
      'account': activeAccount ?? state.activeAccount!,
      'base_url_v2': config.config.api.v2.url,
      'environment': config.environment.environmentString,
    });
  }

  // Send a message to fetch NFT data
  void _sendMessageFetchNFTs(Account? activeAccount) {
    _nftSendPort?.send({
      'account': activeAccount ?? state.activeAccount!,
      'base_url_v2': config.config.api.v2.url,
      'environment': config.environment.environmentString,
    });
  }

  @override
  Future<void> close() {
    _mainTokenReceivePort.close();
    _mainBalanceReceivePort.close();
    _mainNFTReceivePort.close();
    _tokenIsolate.kill();
    _balanceIsolate.kill();
    _nftIsolate.kill();
    return super.close();
  }

  List<double> _calculateBalance(AccountBalance? accountBalance) {
    // If accountBalance is null, return [0, 0] indicating no balance or previous value.
    if (accountBalance == null) return [0, 0];

    double totalBalance = 0; // Initialize total balance for today.
    double totalValueYesterday = 0.0; // Initialize total balance for yesterday.

    // Iterate over each balance in the accountBalance.
    for (final balance in accountBalance.balances) {
      // Find the corresponding token information using tokenId.
      final token = state.tokens.firstWhereOrNull(
        (e) => e.id == balance.tokenId,
      );

      final tokenMarket = state.tokenMarkets.firstWhereOrNull(
        (e) => e.symbol == token?.symbol,
      );

      // Parse the amount of the token balance using a custom decimal format if provided.
      final amount = double.tryParse(
            token?.type.formatBalance(
                  balance.balance,
                  customDecimal: token.decimal,
                ) ??
                '',
          ) ??
          0;

      // Parse the current price of the token, default to 0 if the price is null or not parsable.
      double currentPrice =
          double.tryParse(tokenMarket?.currentPrice ?? '0') ?? 0;

      // Calculate the price of the token yesterday.
      double priceYesterday = currentPrice /
          (1 + (tokenMarket?.priceChangePercentage24h ?? 0) / 100);

      // If the amount or priceYesterday is not zero, add to the total value of yesterday.
      if (amount != 0 || priceYesterday != 0) {
        totalValueYesterday += priceYesterday * amount;
      }

      // If the amount and current price are not zero, add to the total balance for today.
      if (amount != 0 && currentPrice != 0) {
        totalBalance += amount * currentPrice;
      }
    }

    // Return a list with total balance for today and total value for yesterday.
    return [
      totalBalance,
      totalValueYesterday,
    ];
  }

  void _onRefreshTokenBalance(
    HomePageOnRefreshTokenBalanceEvent event,
    Emitter<HomePageState> emit,
  ) {
    _sendMessageFetchAccountBalance(state.activeAccount);
  }

  void _onChangeSelectedAccount(
    HomePageOnChangeAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(
      state.copyWithNull(event.account),
    );

    _sendMessageFetchNFTs(
      event.account,
    );

    _sendMessageFetchAccountBalance(
      event.account,
    );
  }
}

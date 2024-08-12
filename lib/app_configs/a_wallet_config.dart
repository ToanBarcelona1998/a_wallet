import 'package:wallet_core/wallet_core.dart';

enum AWalletEnvironment {
  serenity,
  staging,
  production,
}

extension AWalletEnvironmentMapper on AWalletEnvironment {
  String get environmentString {
    switch (this) {
      case AWalletEnvironment.serenity:
        return 'serenity';
      case AWalletEnvironment.staging:
        return 'euphoria';
      case AWalletEnvironment.production:
        return 'xstaxy';
    }
  }

  ChainInfo get evmChainInfo {
    switch (this) {
      case AWalletEnvironment.serenity:
        return ChainList.auraSerenity;
      case AWalletEnvironment.staging:
        return ChainList.auraEuphoria;
      case AWalletEnvironment.production:
        return ChainList.auraEVM;
    }
  }
}

/// Represents the entire configuration for the A Wallet app.
final class AppConfig {
  final String appName;
  final NativeCoin nativeCoin;
  final CosmosInfoConfig cosmosInfo;
  final EvmInfoConfig evmInfo;
  final ApiConfig api;
  final Web3AuthConfig web3Auth;

  /// Constructor for creating a [AppConfig] instance.
  const AppConfig({
    required this.appName,
    required this.nativeCoin,
    required this.cosmosInfo,
    required this.evmInfo,
    required this.api,
    required this.web3Auth,
  });

  /// Factory method for creating a [AppConfig] instance from a JSON object.
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['APP_NAME'],
      nativeCoin: NativeCoin.fromJson(
        json['NATIVE_COIN'],
      ),
      cosmosInfo: CosmosInfoConfig.fromJson(json['COSMOS_INFO']),
      evmInfo: EvmInfoConfig.fromJson(json['EVM_INFO']),
      api: ApiConfig.fromJson(json['API']),
      web3Auth: Web3AuthConfig.fromJson(json['WEB_3_AUTH']),
    );
  }
}

/// Represents the configuration for native coin
final class NativeCoin {
  final String name;
  final String symbol;

  /// Constructor for creating a [NativeCoin] instance.
  const NativeCoin({
    required this.name,
    required this.symbol,
  });

  /// Factory method for creating a [NativeCoin] instance from a JSON object.
  factory NativeCoin.fromJson(Map<String, dynamic> json) {
    return NativeCoin(
      name: json['name'],
      symbol: json['symbol'],
    );
  }
}

/// Represents the configuration for chain gas price.
final class GasPriceStep {
  final double low;
  final double average;
  final double high;

  /// Constructor for creating a [GasPriceStep] instance.
  const GasPriceStep({
    required this.low,
    required this.average,
    required this.high,
  });

  /// Factory method for creating a [GasPriceStep] instance from a JSON object.
  factory GasPriceStep.fromJson(Map<String, dynamic> json) {
    return GasPriceStep(
      low: json['low'],
      average: json['average'],
      high: json['high'],
    );
  }
}

/// Represents the configuration for the Cosmos chain.
final class CosmosInfoConfig {
  final String symbol;
  final String denom;
  final String chainId;
  final int decimals;
  final String chainName;
  final String rpc;
  final GasPriceStep gasPriceStep;

  /// Constructor for creating a [CosmosInfoConfig] instance.
  CosmosInfoConfig({
    required this.symbol,
    required this.denom,
    required this.chainId,
    required this.decimals,
    required this.chainName,
    required this.rpc,
    required this.gasPriceStep,
  });

  /// Factory method for creating a [CosmosInfoConfig] instance from a JSON object.
  factory CosmosInfoConfig.fromJson(Map<String, dynamic> json) {
    return CosmosInfoConfig(
      symbol: json['symbol'],
      denom: json['denom'],
      chainId: json['chainId'],
      decimals: json['decimals'],
      chainName: json['chainName'],
      rpc: json['rpc'],
      gasPriceStep: GasPriceStep.fromJson(
        json['gasPrice'],
      ),
    );
  }
}

/// Represents the configuration for the EVM chain.
final class EvmInfoConfig {
  final String symbol;
  final String denom;
  final int chainId;
  final int decimals;
  final String chainName;
  final String rpc;
  final GasPriceStep gasPriceStep;

  /// Constructor for creating an [EvmInfoConfig] instance.
  EvmInfoConfig({
    required this.symbol,
    required this.denom,
    required this.chainId,
    required this.decimals,
    required this.chainName,
    required this.rpc,
    required this.gasPriceStep,
  });

  /// Factory method for creating an [EvmInfoConfig] instance from a JSON object.
  factory EvmInfoConfig.fromJson(Map<String, dynamic> json) {
    return EvmInfoConfig(
      symbol: json['symbol'],
      denom: json['denom'],
      chainId: json['chainId'],
      decimals: json['decimals'],
      chainName: json['chainName'],
      rpc: json['rpc'],
      gasPriceStep: GasPriceStep.fromJson(
        json['gasPrice'],
      ),
    );
  }
}

/// Represents the API configuration for the Pyxis Wallet app.
final class ApiConfig {
  final ApiConfigVersion v1;
  final ApiConfigVersion v2;
  final ApiConfigVersion seekHypeEvm;
  final ApiConfigVersion seekHypeCosmos;

  /// Constructor for creating an [ApiConfig] instance.
  ApiConfig({
    required this.v1,
    required this.v2,
    required this.seekHypeEvm,
    required this.seekHypeCosmos,
  });

  /// Factory method for creating an [ApiConfig] instance from a JSON object.
  factory ApiConfig.fromJson(Map<String, dynamic> json) {
    return ApiConfig(
      v1: ApiConfigVersion.fromJson(json['v1']),
      v2: ApiConfigVersion.fromJson(json['v2']),
      seekHypeEvm: ApiConfigVersion.fromJson(json['seek_hype_evm']),
      seekHypeCosmos: ApiConfigVersion.fromJson(json['seek_hype_cosmos']),
    );
  }
}

/// Represents a version of the ApiConfig configuration.
final class ApiConfigVersion {
  final String url;
  final String? graphql;
  final String? rest;
  final String? chain;

  /// Constructor for creating an [ApiConfigVersion] instance.
  ApiConfigVersion({
    required this.url,
    this.graphql,
    this.rest,
    this.chain,
  });

  /// Factory method for creating an [ApiConfigVersion] instance from a JSON object.
  factory ApiConfigVersion.fromJson(Map<String, dynamic> json) {
    return ApiConfigVersion(
      url: json['url'],
      graphql: json['graphql'],
      rest: json['rest'],
      chain: json['chain'],
    );
  }
}

/// Represents the Web3 authentication configuration for the Pyxis Wallet app.
final class Web3AuthConfig {
  final String clientId;
  final String iosRedirectUrl;
  final String androidRedirectUrl;

  /// Constructor for creating a [Web3AuthConfig] instance.
  Web3AuthConfig({
    required this.clientId,
    required this.iosRedirectUrl,
    required this.androidRedirectUrl,
  });

  /// Factory method for creating a [Web3AuthConfig] instance from a JSON object.
  factory Web3AuthConfig.fromJson(Map<String, dynamic> json) {
    return Web3AuthConfig(
      clientId: json['client_id'],
      iosRedirectUrl: json['ios_redirect_url'],
      androidRedirectUrl: json['android_redirect_url'],
    );
  }
}

class AWalletConfig {
  final Map<String, dynamic> configs;
  final AWalletEnvironment environment;

  AWalletConfig({
    required this.configs,
    this.environment = AWalletEnvironment.serenity,
  });

  AppConfig get config => AppConfig.fromJson(
        configs,
      );
}

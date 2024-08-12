import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:domain/domain.dart';


/// Halo trade

const BookMark haloTradeSerenity = BookMark(
  id: -1,
  logo: 'https://dev.zone/favicon-32x32.png',
  name: 'Halotrade.zone',
  url: 'https://dev.halotrade.zone/',
  description: 'The Aura DeFi central hub',
);

const BookMark haloTradeEuphoria = BookMark(
  id: -1,
  logo: 'https://euphoria.halotrade.zone/favicon-32x32.png',
  name: 'Halotrade.zone',
  url: 'https://euphoria.halotrade.zone/',
  description: 'The Aura DeFi central hub',
);

const BookMark haloTrade = BookMark(
  id: -1,
  logo: 'https://halotrade.zone/favicon-32x32.png',
  name: 'Halotrade.zone',
  url: 'https://halotrade.zone',
  description: 'The Aura DeFi central hub',
);

/// Seek hype

const BookMark seekHypeSerenity = BookMark(
  id: -2,
  logo: 'https://hub.serenity.seekhype.io/assets/icons/icon-192x192.png',
  name: 'Seekhype',
  url: 'https://hub.serenity.seekhype.io/',
  description: 'The Simplest NFT Marketplace',
);

const BookMark seekHypeStaging = BookMark(
  id: -2,
  logo: 'https://staging.seekhype.io/assets/icons/icon-192x192.png',
  name: 'Seekhype',
  url: 'https://staging.seekhype.io',
  description: 'The Simplest NFT Marketplace',
);

const BookMark seekHype = BookMark(
  id: -2,
  logo: 'https://beta.seekhype.io/assets/icons/icon-192x192.png',
  name: 'Seekhype',
  url: 'https://beta.seekhype.io/',
  description: 'The Simplest NFT Marketplace',
);


/// Pyxis safe

const BookMark pyxisSafeSerenity = BookMark(
  id: -3,
  logo: 'https://app.pyxis.aura.network/resources/Logo.svg',
  name: 'Pyxis Safe',
  url: 'https://app.pyxis.aura.network/',
  description: 'The multi-signature solution for the Interchain',
);

const BookMark pyxisSafeStaging = BookMark(
  id: -3,
  logo: 'https://app.pyxis.aura.network/resources/Logo.svg',
  name: 'Pyxis Safe',
  url: 'https://app.pyxis.aura.network/',
  description: 'The multi-signature solution for the Interchain',
);

const BookMark pyxisSafe = BookMark(
  id: -3,
  logo: 'https://app.pyxis.aura.network/resources/Logo.svg',
  name: 'Pyxis Safe',
  url: 'https://app.pyxis.aura.network/',
  description: 'The multi-signature solution for the Interchain',
);

/// Aura scan

const BookMark auraScanSerenity = BookMark(
  id: -4,
  logo: 'https://serenity.aurascan.io/assets/images/logo/title-logo.png',
  name: 'Aurascan',
  url: 'https://serenity.aurascan.io/',
  description: 'The Aura blockchain explorer',
);

const BookMark auraScanEuphoria = BookMark(
  id: -4,
  logo: 'https://euphoria.aurascan.io/assets/images/logo/title-logo.png',
  name: 'Aurascan',
  url: 'https://euphoria.aurascan.io/',
  description: 'The Aura blockchain explorer',
);

const BookMark auraScan = BookMark(
  id: -4,
  logo: 'https://aurascan.io/assets/images/logo/title-logo.png',
  name: 'Aurascan',
  url: 'https://aurascan.io/',
  description: 'The Aura blockchain explorer',
);

sealed class AuraEcosystem{
  static late List<BookMark> auraEcosystems;

  static void init(AWalletEnvironment environment){
    auraEcosystems = List.empty(growable: true);
    switch(environment){
      case AWalletEnvironment.serenity:
        auraEcosystems.addAll([
          haloTradeSerenity,
          seekHypeSerenity,
          pyxisSafeSerenity,
          auraScanSerenity,
        ]);
        break;
      case AWalletEnvironment.staging:
        auraEcosystems.addAll([
          haloTradeEuphoria,
          seekHypeStaging,
          pyxisSafeStaging,
          auraScanEuphoria,
        ]);
        break;
      case AWalletEnvironment.production:
        auraEcosystems.addAll([
          haloTrade,
          seekHype,
          pyxisSafe,
          auraScan
        ]);
        break;
    }
  }
}

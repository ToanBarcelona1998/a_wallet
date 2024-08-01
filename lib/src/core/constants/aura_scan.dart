

import 'package:a_wallet/app_configs/pyxis_mobile_config.dart';

sealed class AuraScan{
 static String _domain = _domainSerenity;
 static void init(AWalletEnvironment environment){
  switch(environment){
   case AWalletEnvironment.serenity:
    _domain = _domainSerenity;
    break;
   case AWalletEnvironment.staging:
    _domain = _domainEuphoria;
    break;
   case AWalletEnvironment.production:
    _domain = _domainProduction;
    break;
  }
 }

 static const String _domainSerenity = 'https://serenity.aurascan.io/';
 static const String _domainEuphoria = 'https://euphoria.aurascan.io/';
 static const String _domainProduction = 'https://aurascan.io/';

 static String account(String address) => '${_domain}account/$address';
 static String transaction(String hash) => '${_domain}tx/$hash';
}
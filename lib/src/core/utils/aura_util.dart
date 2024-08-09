import 'dart:math';

import 'package:domain/domain.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'dart_core_extension.dart';

String _replaceDot(String value){
  value = value.replaceAll(RegExp(r'0*$'), '');

  if (value.endsWith('.')) {
    value = value.substring(0, value.length - 1);
  }

  return value;
}

extension AddressExtension on String? {
  String get addressView {
    if (isEmptyOrNull) return '';
    if (this!.length < 32) return this!;

    return '${this!.substring(0, 4)}....${this!.substring(this!.length - 4, this!.length)}';
  }
}

extension FormatAuraByType on TokenType{
  String formatBalance(String balance,{int ?customDecimal}){

    if(customDecimal != null){
      customDecimal = pow(10, customDecimal).toInt();
    }

    int decimal = 1000000000000000000;
    switch(this){
      case TokenType.native:
        break;
      case TokenType.erc20:
        decimal = customDecimal ?? decimal;
        break;
    }

    double auraD = double.tryParse(balance) ?? 0;

    String auraString = (auraD / decimal).toStringAsFixed(6);

    return _replaceDot(auraString);
  }

  BigInt formatBalanceToInt(String balance,{int ?customDecimal}){

    if(customDecimal != null){
      customDecimal = pow(10, customDecimal).toInt();
    }

    int decimal = 1000000000000000000;
    switch(this){
      case TokenType.native:
        break;
      case TokenType.erc20:
        decimal = customDecimal ?? decimal;
        break;
    }

    double auraD = double.tryParse(balance) ?? 0;

    String auraString = (auraD * decimal).toStringAsFixed(6);

    return BigInt.parse(_replaceDot(auraString));
  }
}

extension AuraNumberFormatter on num {

  bool get  isIncrease => this > 0;

  String get prefixValueChange{
    if(isIncrease){
      return '+';
    }
    return '';
  }


  String get formatPercent{
    String percent = toStringAsFixed(2);

    return _replaceDot(percent);
  }

  String get formatPrice {
    if (this == 0) return '0';

    String price = toStringAsFixed(2);

    return _replaceDot(price);
  }

  String get formatPnl24 {
    if (this == 0) return '0';

    String price = toStringAsFixed(4);

    return _replaceDot(price);
  }

  String get formatBalance{
    if (this == 0) return '0';

    String balance = toStringAsFixed(6);

    return _replaceDot(balance);
  }
}

String randomAvatar() {
  Random random = Random(128);

  int index = random.nextInt(2);

  return AppLocalConstant.avatars[index];
}



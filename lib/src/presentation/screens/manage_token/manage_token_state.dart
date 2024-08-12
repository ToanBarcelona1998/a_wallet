import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_token_state.freezed.dart';

extension TokenExtension on Token {
  Token copyWithEnable() {
    return Token(
      id: id,
      logo: logo,
      tokenName: tokenName,
      type: type,
      symbol: symbol,
      contractAddress: contractAddress,
      isEnable: !isEnable,
      decimal: decimal,
    );
  }
}

enum ManageTokenStatus {
  none,
  loading,
  loaded,
  error,
  onChangeDone,
}

enum ManageTokenFilterType {
  all,
  custom,
  disable,
  enable,
}

@freezed
class ManageTokenState with _$ManageTokenState {
  const factory ManageTokenState({
    @Default(ManageTokenStatus.none) ManageTokenStatus status,
    @Default(ManageTokenFilterType.all) ManageTokenFilterType filterType,
    @Default([]) List<Token> tokens,
    @Default(false) bool isHideSmallBalance,
  }) = _ManageTokenState;
}

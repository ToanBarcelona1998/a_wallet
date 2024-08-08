import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_token_state.freezed.dart';

enum ManageTokenStatus {
  none,
  loading,
  loaded,
  error,
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

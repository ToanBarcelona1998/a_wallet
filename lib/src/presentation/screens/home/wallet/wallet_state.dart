import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_state.freezed.dart';

enum WalletStatus {
  none,
  loading,
  loaded,
  error,
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.none) WalletStatus status,
    @Default([]) List<Account> accounts,
    String ?error,
  }) = _WalletState;
}

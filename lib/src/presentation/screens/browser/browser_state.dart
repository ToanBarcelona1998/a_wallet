import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_state.freezed.dart';

extension BrowserStateExtension on BrowserState {
  BrowserState copyWithBookMarkNull({
    Account? selectedAccount,
    int? tabCount,
    List<Account>? accounts,
    String? url,
    bool? canGoNext,
    Browser? currentBrowser,
    BrowserStatus ? status,
  }) {
    return BrowserState(
      tabCount: tabCount ?? this.tabCount,
      accounts: accounts ?? this.accounts,
      currentUrl: url ?? currentUrl,
      bookMark: null,
      canGoNext: canGoNext ?? this.canGoNext,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      currentBrowser: currentBrowser ?? this.currentBrowser,
      status: status ?? this.status,
    );
  }
}

enum BrowserStatus {
  none,
  changeBookMarkSuccess,
  addNewBrowserSuccess,
}

@freezed
class BrowserState with _$BrowserState {
  const factory BrowserState({
    @Default(
      BrowserStatus.none,
    )
    BrowserStatus status,
    @Default([]) List<Account> accounts,
    Account? selectedAccount,
    BookMark? bookMark,
    Browser? currentBrowser,
    @Default('') String currentUrl,
    @Default(false) bool canGoNext,
    @Default(1) int tabCount,
  }) = _BrowserState;
}

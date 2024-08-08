import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tab_management_state.freezed.dart';

enum BrowserTabManagementStatus {
  loading,
  loaded,
  addTabSuccess,
  closeTabSuccess,
  closeAllSuccess,
}

@freezed
class BrowserTabManagementState with _$BrowserTabManagementState {
  const factory BrowserTabManagementState({
    @Default(BrowserTabManagementStatus.loading)
    BrowserTabManagementStatus status,
    @Default([]) List<Browser> browsers,
    Browser ?activeBrowser
  }) = _BrowserTabManagementState;
}

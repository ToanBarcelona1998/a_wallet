import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tab_management_event.freezed.dart';

@freezed
class BrowserTabManagementEvent with _$BrowserTabManagementEvent {
  const factory BrowserTabManagementEvent.onInit() =
      BrowserTabManagementOnInitEvent;

  const factory BrowserTabManagementEvent.onClear() =
      BrowserTabManagementOnClearEvent;

  const factory BrowserTabManagementEvent.onCloseTab({
    required int id,
  }) = BrowserTabManagementOnCloseTabEvent;

  const factory BrowserTabManagementEvent.onAddNewTab() = BrowserTabManagementOnAddNewTabEvent;
}

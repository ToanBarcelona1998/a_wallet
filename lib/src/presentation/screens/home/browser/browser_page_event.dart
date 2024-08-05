import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_page_event.freezed.dart';

@freezed
class BrowserPageEvent with _$BrowserPageEvent {
  const factory BrowserPageEvent.onInit() = BrowserPageOnInitEvent;

  const factory BrowserPageEvent.onChangeTab({
    required int index,
  }) = BrowserPageOnChangeTabEvent;

  const factory BrowserPageEvent.onDeleteBookMark({
    required int id,
  }) = BrowserPageOnDeleteBookMarkEvent;

  const factory BrowserPageEvent.onRefreshBookMark() = BrowserPageOnRefreshBookMarkEvent;

  const factory BrowserPageEvent.onRefreshTab() = BrowserPageOnRefreshTabEvent;
}

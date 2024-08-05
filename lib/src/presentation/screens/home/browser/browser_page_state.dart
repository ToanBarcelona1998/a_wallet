import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_page_state.freezed.dart';

@freezed
class BrowserPageState with _$BrowserPageState {
  const factory BrowserPageState({
    @Default([]) List<BookMark> ecosystems,
    @Default([]) List<BookMark> bookMarks,
    @Default(1) int tabCount,
    @Default(0) int currentTab,
  }) = _BrowserPageState;
}

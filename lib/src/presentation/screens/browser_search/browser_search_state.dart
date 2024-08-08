import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_search_state.freezed.dart';

@freezed
class BrowserSearchState with _$BrowserSearchState {
  const factory BrowserSearchState({
    @Default([]) List<BookMark> systems,
    @Default('') String query,
  }) = _BrowserSearchState;
}

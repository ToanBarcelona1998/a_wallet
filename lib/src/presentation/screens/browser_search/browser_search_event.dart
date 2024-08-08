import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_search_event.freezed.dart';

@freezed
class BrowserSearchEvent with _$BrowserSearchEvent {
  const factory BrowserSearchEvent.onQuery({
    required String query,
  }) = BrowserSearchOnQueryEvent;
}

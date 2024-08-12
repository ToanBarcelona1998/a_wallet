import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_token_event.freezed.dart';

@freezed
class ManageTokenEvent with _$ManageTokenEvent{
  const factory ManageTokenEvent.init() = ManageTokenOnInitEvent;
  const factory ManageTokenEvent.onRefresh() = ManageTokenOnRefreshEvent;
  const factory ManageTokenEvent.onSearch(String tokenName) = ManageTokenOnSearchEvent;
  const factory ManageTokenEvent.onDenounceToken(Token token) = ManageTokenOnDenounceEvent;
  const factory ManageTokenEvent.onDenounceDone(Token token) = ManageTokenOnDenounceDoneEvent;
}
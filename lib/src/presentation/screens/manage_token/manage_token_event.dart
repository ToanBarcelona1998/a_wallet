import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_token_event.freezed.dart';

@freezed
class ManageTokenEvent with _$ManageTokenEvent{
  const factory ManageTokenEvent.init() = ManageTokenOnInitEvent;
}
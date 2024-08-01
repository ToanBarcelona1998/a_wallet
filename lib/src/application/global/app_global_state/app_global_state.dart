import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_global_state.freezed.dart';

enum AppGlobalStatus {
  unauthorized,
  authorized,
}

@freezed
class AppGlobalState with _$AppGlobalState {
  const factory AppGlobalState({
    @Default(AppGlobalStatus.unauthorized) AppGlobalStatus status,
    // @Default(AppNetwork.custom) AppNetwork selectedNetwork,
  }) = _AppGlobalState;
}

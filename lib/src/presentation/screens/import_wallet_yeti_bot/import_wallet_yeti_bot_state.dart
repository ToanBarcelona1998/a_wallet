import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'import_wallet_yeti_bot_state.freezed.dart';

enum ImportWalletYetiBotStatus {
  none,
  storing,
  stored,
}

@freezed
class ImportWalletYetiBotState with _$ImportWalletYetiBotState {
  const factory ImportWalletYetiBotState({
    @Default(ImportWalletYetiBotStatus.none) ImportWalletYetiBotStatus status,
    required AWallet wallet,
    required AppNetwork appNetwork,
    @Default(false) bool isReady,
  }) = _ImportWalletYetiBotState;
}

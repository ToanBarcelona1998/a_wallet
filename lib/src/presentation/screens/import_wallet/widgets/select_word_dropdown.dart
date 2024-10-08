import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/screens/import_wallet/widgets/select_word_widget.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';

final class ImportWalletSelectWordDropdownWidget extends AppBottomSheetBase {
  final int currentWord;
  final void Function(int) onSelected;
  const ImportWalletSelectWordDropdownWidget({
    required super.appTheme,
    super.key,
    super.onClose,
    required super.localization,
    required this.onSelected,
    required this.currentWord,
  });

  @override
  State<StatefulWidget> createState() =>
      _ImportWalletSelectWordDropdownWidgetState();
}

final class _ImportWalletSelectWordDropdownWidgetState
    extends AppBottomSheetBaseState<ImportWalletSelectWordDropdownWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.importWalletScreenSelectWordNumberTitle,
      ),
      style: AppTypoGraPhy.textMdSemiBold.copyWith(
        color: appTheme.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        ImportSelectWordWidget(
          word: 12,
          currentWord: widget.currentWord,
          appTheme: appTheme,
          localization: localization,
          onSelected: _onSelect,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        ImportSelectWordWidget(
          word: 24,
          currentWord: widget.currentWord,
          appTheme: appTheme,
          localization: localization,
          onSelected: _onSelect,
        ),
      ],
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  void _onSelect(int word){
    AppNavigator.pop();
    if(widget.currentWord != word){
      widget.onSelected(word);
    }
  }
}

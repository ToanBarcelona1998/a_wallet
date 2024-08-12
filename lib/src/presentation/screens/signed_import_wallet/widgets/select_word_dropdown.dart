import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'select_word_widget.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';

final class SignedImportWalletSelectWordDropdownWidget extends AppBottomSheetBase {
  final int currentWord;
  final void Function(int) onSelected;
  const SignedImportWalletSelectWordDropdownWidget({
    required super.appTheme,
    super.key,
    super.onClose,
    required super.localization,
    required this.onSelected,
    required this.currentWord,
  });

  @override
  State<StatefulWidget> createState() =>
      _SignedImportWalletSelectWordDropdownWidgetState();
}

final class _SignedImportWalletSelectWordDropdownWidgetState
    extends AppBottomSheetBaseState<SignedImportWalletSelectWordDropdownWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.signedImportWalletScreenSelectWordNumberTitle,
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
        SignedImportSelectWordWidget(
          word: 12,
          currentWord: widget.currentWord,
          appTheme: appTheme,
          localization: localization,
          onSelected: _onSelect,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        SignedImportSelectWordWidget(
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

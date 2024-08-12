import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class _SendAddressBookWidget extends StatelessWidget {
  final String name;
  final String address;
  final AppTheme appTheme;
  final VoidCallback onTap;

  const _SendAddressBookWidget({
    required this.name,
    required this.address,
    required this.appTheme,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypoGraPhy.textLgBold.copyWith(
                    color: appTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: BoxSize.boxSize02,
                ),
                Text(
                  address.addressView,
                  style: AppTypoGraPhy.textSmMedium.copyWith(
                    color: appTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class SendSelectContractWidget extends AppBottomSheetBase {
  final List<AddressBook> addressBooks;

  const SendSelectContractWidget({
    required super.appTheme,
    required super.localization,
    required this.addressBooks,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SendSelectContactWidgetState();
}

final class _SendSelectContactWidgetState
    extends AppBottomSheetBaseState<SendSelectContractWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget titleBuilder(BuildContext context) {
    return Column(
      children: [
        Text(
          localization.translate(
            LanguageKey.sendScreenSelectAddress,
          ),
          style: AppTypoGraPhy.textLgBold.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: BoxSize.boxSize14,
        maxHeight: BoxSize.boxSize18,
      ),
      child: Builder(builder: (context) {
        if (widget.addressBooks.isEmpty) {
          return Center(
            child: Text(
              localization.translate(
                LanguageKey.sendScreenSelectAddressNotFound,
              ),
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: appTheme.textSecondary,
              ),
            ),
          );
        }
        return CombinedListView(
          onRefresh: () {},
          onLoadMore: () {},
          data: widget.addressBooks,
          builder: (addressBook, _) {
            return _SendAddressBookWidget(
              name: addressBook.name,
              address: addressBook.address,
              onTap: () {
                AppNavigator.pop(addressBook);
              },
              appTheme: appTheme,
            );
          },
          canLoadMore: false,
        );
      }),
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
}

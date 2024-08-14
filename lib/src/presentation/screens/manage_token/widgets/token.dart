import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/manage_token/manage_token_selector.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:a_wallet/src/presentation/widgets/switch_widget.dart';

final class _ManageTokenScreenTokenWidget extends StatelessWidget {
  final String logo;
  final String name;
  final String networkName;
  final bool isEnable;
  final void Function(bool) onChanged;
  final AppTheme appTheme;

  const _ManageTokenScreenTokenWidget({
    required this.name,
    required this.logo,
    required this.networkName,
    required this.onChanged,
    required this.isEnable,
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NetworkImageWidget(
              url: logo,
              appTheme: appTheme,
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypoGraPhy.textMdBold.copyWith(
                      color: appTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: BoxSize.boxSize02,
                  ),
                  Text(
                    networkName,
                    style: AppTypoGraPhy.textXsMedium.copyWith(
                      color: appTheme.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            SwitchWidget(
              onChanged: onChanged,
              isSelected: isEnable,
              appTheme: appTheme,
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        HoLiZonTalDividerWidget(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }
}

class ManageTokenScreenTokensWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final void Function(Token) onChanged;

  const ManageTokenScreenTokensWidget({
    required this.appTheme,
    required this.localization,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.translate(
                LanguageKey.manageTokenScreenShowTitle,
              ),
              style: AppTypoGraPhy.textMdSemiBold.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
            // SvgPicture.asset(
            //   AssetIconPath.icCommonFilter,
            // ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        Expanded(
          child: ManageTokenTokensSelector(
            builder: (tokens) {
              return CombinedListView(
                onRefresh: () {},
                onLoadMore: () {},
                data: tokens,
                builder: (token, _) {
                  return _ManageTokenScreenTokenWidget(
                    name: token.tokenName,
                    logo: token.logo,
                    networkName: token.symbol,
                    onChanged: (value) {
                      onChanged(token);
                    },
                    isEnable: token.isEnable,
                    appTheme: appTheme,
                  );
                },
                canLoadMore: false,
              );
            },
          ),
        ),
      ],
    );
  }
}

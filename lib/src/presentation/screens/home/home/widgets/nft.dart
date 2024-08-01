import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_date_format.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/presentation/screens/home/home/home_page_selector.dart';
import 'package:a_wallet/src/presentation/widgets/box_widget.dart';
import 'package:a_wallet/src/presentation/widgets/combined_gridview.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';

class _HomePageNFTCardWidget extends StatelessWidget {
  final String thumbnail;
  final String name;
  final String createTime;
  final String price;
  final String id;
  final AppTheme appTheme;
  final MediaType mediaType;

  const _HomePageNFTCardWidget({
    required this.id,
    required this.name,
    required this.createTime,
    required this.price,
    required this.thumbnail,
    required this.appTheme,
    this.mediaType = MediaType.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              BorderRadiusSize.borderRadius04,
            ),
            child: Stack(
              children: [
                NetworkImageWidget(
                  appTheme: appTheme,
                  cacheTarget: context.cacheImageTarget,
                  url: thumbnail,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
                // Positioned(
                //   top: Spacing.spacing03,
                //   right: Spacing.spacing03,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       vertical: Spacing.spacing01,
                //       horizontal: Spacing.spacing03,
                //     ),
                //     decoration: BoxDecoration(
                //       color: appTheme.surfaceColorBlack.withOpacity(
                //         0.5,
                //       ),
                //       borderRadius: BorderRadius.circular(
                //         BorderRadiusSize.borderRadiusRound,
                //       ),
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       idToken,
                //       style: AppTypoGraPhy.body01.copyWith(
                //         color: appTheme.contentColorWhite,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize02,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: AppTypoGraPhy.textMdBold.copyWith(
                  color: appTheme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            Text(
              '#$id',
              style: AppTypoGraPhy.textSmRegular.copyWith(
                color: appTheme.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize01,
        ),
        Text(
          AppDateTime.formatDateHHMMDMMMYYY(
            createTime,
          ),
          style: AppTypoGraPhy.textXsRegular.copyWith(
            color: appTheme.textTertiary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize01,
        ),
        Text(
          price,
          style: AppTypoGraPhy.textSmBold.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

final class HomePageNFTsWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const HomePageNFTsWidget({
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.translate(
                    LanguageKey.homePageEstimateNFTValue,
                  ),
                  style: AppTypoGraPhy.textSmMedium
                      .copyWith(color: appTheme.textSecondary),
                ),
                const SizedBox(
                  height: BoxSize.boxSize02,
                ),
                HomePageTotalTokenValueSelector(builder: (totalTokenBalance) {
                  return Text(
                    '0.0',
                    style: AppTypoGraPhy.textXlBold
                        .copyWith(color: appTheme.textPrimary),
                  );
                }),
              ],
            ),
            BoxBorderTextWidget(
              text: localization.translate(
                LanguageKey.homePageViewAllNFT,
              ),
              borderColor: appTheme.borderSecondary,
              padding: const EdgeInsets.all(
                Spacing.spacing03,
              ),
              appTheme: appTheme,
              radius: BorderRadiusSize.borderRadius04,
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        HomePageNFTsSelector(
          builder: (nftS) {
            if (nftS.isEmpty) {
              return Text(
                localization.translate(
                  LanguageKey.homePageNoNFTFound,
                ),
                style: AppTypoGraPhy.textXsRegular.copyWith(
                  color: appTheme.textTertiary,
                ),
                textAlign: TextAlign.center,
              );
            }
            return SizedBox(
              height: context.bodyHeight * 0.7,
              child: CombinedGridView(
                childCount: 2,
                onRefresh: () {},
                onLoadMore: () {},
                data: nftS,
                physics: const NeverScrollableScrollPhysics(),
                builder: (nft, _) {
                  return _HomePageNFTCardWidget(
                    id: nft.tokenId,
                    name: nft.mediaInfo.onChain.metadata?.name ?? '',
                    createTime: nft.createdAt.toString(),
                    price: "--",
                    thumbnail: nft.mediaInfo.offChain.image.url ?? '',
                    appTheme: appTheme,
                  );
                },
                canLoadMore: false,
                childAspectRatio: 0.72,
                crossAxisSpacing: Spacing.spacing04,
                mainAxisSpacing: Spacing.spacing05,
              ),
            );
          },
        ),
      ],
    );
  }
}

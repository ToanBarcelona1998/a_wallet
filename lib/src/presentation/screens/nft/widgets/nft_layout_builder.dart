import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_bloc.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_event.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_selector.dart';
import 'package:a_wallet/src/presentation/screens/nft/widgets/nft_vertical_card.dart';
import 'package:a_wallet/src/presentation/widgets/combined_gridview.dart';
import 'nft_horizontal_card.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';

class NFTScreenLayoutBuilder extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const NFTScreenLayoutBuilder({
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NFTLayoutViewTypeSelector(
      builder: (viewType) {
        return NFTInformationSSelector(
          builder: (nFTs) {
            if (nFTs.isEmpty) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async => _onRefresh(context),
                  ),
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        localization.translate(
                          LanguageKey.nftScreenNoNFTFound,
                        ),
                        style: AppTypoGraPhy.textSmMedium.copyWith(
                          color: appTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return NFTCanLoadMoreSelector(
              builder: (canLoadMore) {
                return AnimatedCrossFade(
                  duration: const Duration(
                    milliseconds: 700,
                  ),
                  crossFadeState: viewType == NFTLayoutType.grid
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  secondChild: _buildListView(
                    context,
                    nFTs,
                    canLoadMore,
                  ),
                  firstChild: _buildGridView(
                    context,
                    nFTs,
                    canLoadMore,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildGridView(
    BuildContext context,
    List<NFTInformation> nFTs,
    bool canLoadMore,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: CombinedGridView(
        childCount: 2,
        onRefresh: () {
          _onRefresh(context);
        },
        onLoadMore: () {
          if (canLoadMore) {
            _onLoadMore(context);
          }
        },
        data: nFTs,
        builder: (nft, index) {
          return GestureDetector(
            onTap: () {
              AppNavigator.push(
                RoutePath.nftDetail,
                nft,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: NFTScreenVerticalCard(
              name: nft.mediaInfo.onChain.metadata?.name ?? '',
              url: nft.mediaInfo.offChain.image.url ?? '',
              appTheme: appTheme,
              idToken: '#${nft.tokenId}',
              key: ValueKey(nft),
              localization: localization,
              createTime: nft.createdAt.toString(),
            ),
          );
        },
        canLoadMore: canLoadMore,
        childAspectRatio: 0.85,
        crossAxisSpacing: Spacing.spacing06,
        mainAxisSpacing: Spacing.spacing07,
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    List<NFTInformation> nFTs,
    bool canLoadMore,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: CombinedListView(
        onRefresh: () {
          _onRefresh(context);
        },
        onLoadMore: () {
          if (canLoadMore) {
            _onLoadMore(context);
          }
        },
        data: nFTs,
        builder: (nft, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: Spacing.spacing05,
            ),
            child: GestureDetector(
              onTap: () {
                AppNavigator.push(
                  RoutePath.nftDetail,
                  nft,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: NFTScreenHorizontalCard(
                name: nft.mediaInfo.onChain.metadata?.name ?? '',
                url: nft.mediaInfo.offChain.image.url ?? '',
                appTheme: appTheme,
                idToken: '#${nft.tokenId}',
                key: ValueKey(nft),
                localization: localization,
                createTime: nft.createdAt.toString(),
              ),
            ),
          );
        },
        canLoadMore: canLoadMore,
      ),
    );
  }

  void _onLoadMore(
    BuildContext context,
  ) {
    NFTBloc.of(context).add(
      const NFTEventOnLoadMore(),
    );
  }

  void _onRefresh(
    BuildContext context,
  ) {
    NFTBloc.of(context).add(
      const NFTEventOnRefresh(),
    );
  }
}

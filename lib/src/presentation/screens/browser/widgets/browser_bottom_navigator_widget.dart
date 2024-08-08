import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/presentation/screens/browser/browser_selector.dart';
import 'package:a_wallet/src/presentation/widgets/circle_avatar_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserScreenBottomNavigatorWidget extends StatelessWidget {
  final AppTheme appTheme;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onBookmarkClick;
  final VoidCallback onHomeClick;
  final void Function(
    List<Account>,
    Account?,
  ) onAccountClick;

  const BrowserScreenBottomNavigatorWidget({
    required this.appTheme,
    required this.onNext,
    required this.onBack,
    required this.onBookmarkClick,
    required this.onHomeClick,
    required this.onAccountClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.bgPrimary,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing05,
        vertical: Spacing.spacing04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AssetIconPath.icBrowserScreenBack,
            ),
          ),
          BrowserCanGoNextSelector(
            builder: (canGoNext) {
              return GestureDetector(
                onTap: onNext,
                behavior: HitTestBehavior.opaque,
                child: canGoNext
                    ? SvgPicture.asset(
                        AssetIconPath.icBrowserScreenNextBold,
                      )
                    : SvgPicture.asset(
                        AssetIconPath.icBrowserScreenNext,
                      ),
              );
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onHomeClick,
            child: SvgPicture.asset(
              AssetImagePath.yetiBot,
            ),
          ),
          GestureDetector(
            onTap: onBookmarkClick,
            behavior: HitTestBehavior.opaque,
            child: BrowserBookMarkSelector(
              builder: (bookMark) {
                return bookMark != null
                    ? SvgPicture.asset(
                        AssetIconPath.icBrowserScreenBookmarkActive,
                      )
                    : SvgPicture.asset(
                        AssetIconPath.icBrowserScreenBookmark,
                      );
              },
            ),
          ),
          BrowserAccountsSelector(
            builder: (accounts) {
              return BrowserSelectedAccountSelector(
                builder: (selectedAccount) {
                  return GestureDetector(
                    onTap: () {
                      onAccountClick(accounts, selectedAccount);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: CircleAvatarWidget(
                      image: AssetImage(
                        randomAvatar(),
                      ),
                      radius: BorderRadiusSize.borderRadius03M,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

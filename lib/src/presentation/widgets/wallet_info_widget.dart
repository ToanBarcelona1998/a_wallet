import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'circle_avatar_widget.dart';

abstract class WalletInfoWidget extends StatelessWidget {
  final AppTheme appTheme;
  final String title;
  final String address;

  const WalletInfoWidget({
    required this.appTheme,
    required this.title,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        avatar(context),
        const SizedBox(
          width: BoxSize.boxSize05,
        ),
        Expanded(
          child: content(context),
        ),
        const SizedBox(
          width: BoxSize.boxSize05,
        ),
        actions(context),
      ],
    );
  }

  Widget avatar(
    BuildContext context,
  );

  Widget actions(
    BuildContext context,
  );

  Widget content(BuildContext context);
}

final class DefaultWalletInfoWidget extends WalletInfoWidget {
  final String avatarAsset;

  const DefaultWalletInfoWidget({
    super.key,
    required this.avatarAsset,
    required super.appTheme,
    required super.title,
    required super.address,
  });

  @override
  Widget actions(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget avatar(BuildContext context) {
    return CircleAvatarWidget(
      image: AssetImage(
        avatarAsset,
      ),
      radius: BorderRadiusSize.borderRadius04M,
    );
  }

  @override
  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              AppTypoGraPhy.textMdBold.copyWith(color: appTheme.textPrimary),
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
    );
  }
}

final class WalletInfoWithCustomActionsWidget extends WalletInfoWidget {
  final String avatarAsset;
  final Widget action;

  const WalletInfoWithCustomActionsWidget({
    super.key,
    required this.avatarAsset,
    required super.appTheme,
    required super.title,
    required super.address,
    required this.action,
  });

  @override
  Widget actions(BuildContext context) {
    return action;
  }

  @override
  Widget avatar(BuildContext context) {
    if(avatarAsset.endsWith('svg')){
      return SvgPicture.asset(avatarAsset);
    }
    return CircleAvatarWidget(
      image: AssetImage(
        avatarAsset,
      ),
      radius: BorderRadiusSize.borderRadius04M,
    );
  }

  @override
  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
          address.addressView,
          style: AppTypoGraPhy.textSmMedium.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

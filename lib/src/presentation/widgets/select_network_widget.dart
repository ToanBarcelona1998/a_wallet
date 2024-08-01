import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';

final class SelectNetworkWidget extends AppBottomSheetBase {
  final List<AppNetwork> networks;

  const SelectNetworkWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.networks,
  });

  @override
  State<StatefulWidget> createState() => _SelectNetworkWidgetState();
}

class _SelectNetworkWidgetState
    extends AppBottomSheetBaseState<SelectNetworkWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.commonSelectNetwork,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    throw UnimplementedError();
    // return Column(
    //   children: widget.networks.map(
    //     (e) {
    //       return AppNetworkWidget(
    //         logo: logo,
    //         network: network,
    //         appTheme: appTheme,
    //         isSelected: isSelected,
    //       );
    //     },
    //   ).toList(),
    // );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }
}

final class AppNetworkWidget extends StatelessWidget {
  final String logo;
  final String network;
  final AppTheme appTheme;
  final bool isSelected;

  const AppNetworkWidget({
    required this.logo,
    required this.network,
    required this.appTheme,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing04,
      ),
      decoration: BoxDecoration(
        color: isSelected ? appTheme.bgBrandPrimary : appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            logo,
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          Expanded(
            child: Text(
              network,
              style: AppTypoGraPhy.textSmBold.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
          ),
          if (isSelected) ...[
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            SvgPicture.asset(
              AssetIconPath.icCommonYetiHand,
            ),
          ],
        ],
      ),
    );
  }
}

abstract class AccountNetworkWidgetBase extends StatelessWidget {
  final String logo;
  final String network;
  final AppTheme appTheme;
  final String address;

  const AccountNetworkWidgetBase({
    required this.logo,
    required this.network,
    required this.appTheme,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing04,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            logo,
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  network,
                  style: AppTypoGraPhy.textSmBold.copyWith(
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
                    color: appTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          actions(context),
        ],
      ),
    );
  }

  Widget actions(BuildContext context);
}

final class SelectNetworkAccountWidget extends AppBottomSheetBase {
  final List<AppNetwork> networks;
  final Account account;

  const SelectNetworkAccountWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.networks,
    required this.account,
  });

  @override
  State<StatefulWidget> createState() => _SelectNetworkAccountWidgetState();
}

class _SelectNetworkAccountWidgetState
    extends AppBottomSheetBaseState<SelectNetworkAccountWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.commonSelectNetwork,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.networks.map(
        (e) {
          return GestureDetector(
            onTap: () {
              AppNavigator.pop(e);
            },
            behavior: HitTestBehavior.opaque,
            child: AccountNetworkWidget(
              logo: e.logo,
              network: e.name,
              appTheme: appTheme,
              address: e.getAddress(
                widget.account,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }
}

final class AccountNetworkWidget extends AccountNetworkWidgetBase {
  const AccountNetworkWidget({
    required super.logo,
    required super.network,
    required super.appTheme,
    required super.address,
    super.key,
  });

  @override
  Widget actions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        SvgPicture.asset(
          AssetIconPath.icCommonArrowNext,
        ),
      ],
    );
  }
}

final class SelectNetworkAccountReceiveWidget extends AppBottomSheetBase {
  final List<AppNetwork> networks;
  final Account account;
  final void Function(String) onCopy;
  final void Function(Account, AppNetwork) onShowQr;

  const SelectNetworkAccountReceiveWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.networks,
    required this.account,
    required this.onCopy,
    required this.onShowQr,
  });

  @override
  State<StatefulWidget> createState() =>
      _SelectNetworkAccountReceiveWidgetState();
}

class _SelectNetworkAccountReceiveWidgetState
    extends AppBottomSheetBaseState<SelectNetworkAccountReceiveWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.commonSelectNetwork,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.networks.map(
        (e) {
          String address = e.getAddress(
            widget.account,
          );
          return AccountNetworkReceiveWidget(
            logo: e.logo,
            network: e.name,
            appTheme: appTheme,
            address: address,
            onCopy: () {
              widget.onCopy(address);
            },
            onShowQr: () {
              widget.onShowQr(widget.account,e);
            },
          );
        },
      ).toList(),
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }
}

final class AccountNetworkReceiveWidget extends AccountNetworkWidgetBase {
  final VoidCallback onShowQr;
  final VoidCallback onCopy;

  const AccountNetworkReceiveWidget({
    required super.logo,
    required super.network,
    required super.appTheme,
    required super.address,
    required this.onShowQr,
    required this.onCopy,
    super.key,
  });

  @override
  Widget actions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onShowQr,
          child: SvgPicture.asset(
            AssetIconPath.icCommonQr,
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onCopy,
          child: SvgPicture.asset(
            AssetIconPath.icCommonCopy,
          ),
        ),
      ],
    );
  }
}

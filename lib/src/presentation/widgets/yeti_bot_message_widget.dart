import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';

final class YetiBotMessageObject<T> {
  final int groupId;
  final String data;
  final T? object;

  // 0 == text , and add others case if need.
  final int type;

  const YetiBotMessageObject({
    required this.data,
    required this.groupId,
    this.object,
    required this.type,
  });

  bool get isTextMessage => type == 0;
}

abstract class YetiBotMessageWidget extends StatelessWidget {
  final AppTheme appTheme;

  const YetiBotMessageWidget({
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing05,
        vertical: Spacing.spacing04,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            BorderRadiusSize.borderRadius03,
          ),
          topRight: Radius.circular(
            BorderRadiusSize.borderRadius04,
          ),
          bottomLeft: Radius.circular(
            BorderRadiusSize.borderRadius04,
          ),
          bottomRight: Radius.circular(
            BorderRadiusSize.borderRadius03,
          ),
        ),
        color: appTheme.bgPrimary,
      ),
      child: child(context),
    );
  }

  Widget child(BuildContext context);
}

final class YetiBotTextMessageWidget extends YetiBotMessageWidget {
  final String text;

  const YetiBotTextMessageWidget({
    required super.appTheme,
    required this.text,
    super.key,
  });

  @override
  Widget child(BuildContext context) {
    return Text(
      text,
      style: AppTypoGraPhy.textSmRegular.copyWith(
        color: appTheme.textPrimary,
      ),
      textAlign: TextAlign.start,
    );
  }
}

final class YetiBotAddressMessageWidget extends YetiBotMessageWidget {
  final String text;
  final List<String> addresses;
  final void Function(String)? opCopy;

  const YetiBotAddressMessageWidget({
    required super.appTheme,
    required this.text,
    required this.addresses,
    this.opCopy,
    super.key,
  });

  @override
  Widget child(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTypoGraPhy.textSmRegular.copyWith(
            color: appTheme.textPrimary,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: BoxSize.boxSize04,
        ),
        Column(
          children: addresses.map((address) {
            return GestureDetector(
              onTap: () =>  opCopy?.call(address),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.spacing03,
                  vertical: Spacing.spacing02,
                ),
                margin: const EdgeInsets.only(
                  bottom: Spacing.spacing03,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    BorderRadiusSize.borderRadius03,
                  ),
                  color: appTheme.bgSecondary,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        address.addressView,
                      ),
                    ),
                    const SizedBox(
                      width: BoxSize.boxSize04,
                    ),
                    SvgPicture.asset(
                      AssetIconPath.icCommonCopy,
                    ),
                  ],
                ),
              ),
            );
          },).toList(),
        ),
      ],
    );
  }
}

final class YetiBotMessageBuilder extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final YetiBotMessageObject messageObject;
  final int? nextGroup;
  final int? lastGroup;
  final void Function(String)? onCopy;

  const YetiBotMessageBuilder({
    required this.appTheme,
    required this.localization,
    required this.messageObject,
    this.nextGroup,
    this.lastGroup,
    this.onCopy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildAvtGroup(),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.w * 0.65,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (messageObject.groupId != nextGroup)
                ... [
                  const SizedBox(
                    height: BoxSize.boxSize02,
                  ),
                  Text(
                    localization.translate(
                      LanguageKey.commonYetiBot,
                    ),
                    style: AppTypoGraPhy.textXsRegular.copyWith(
                      color: appTheme.textTertiary,
                    ),
                  ),
                ]
              else
                const SizedBox.shrink(),
              buildMessage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAvtGroup() {
    if (messageObject.groupId != lastGroup) {
      return SvgPicture.asset(
        AssetImagePath.yetiBot,
      );
    }

    return const SizedBox(
      width: BoxSize.boxSize08,
      height: BoxSize.boxSize08,
    );
  }

  Widget buildMessage() {
    // If need many cases. Use type for detection.
    if (messageObject.isTextMessage) {
      return YetiBotTextMessageWidget(
        appTheme: appTheme,
        text: messageObject.data,
      );
    }

    return YetiBotAddressMessageWidget(
      appTheme: appTheme,
      text: messageObject.data,
      addresses: messageObject.object,
      opCopy: onCopy,
    );
  }
}

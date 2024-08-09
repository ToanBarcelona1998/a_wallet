import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/json_formatter.dart';
import 'package:a_wallet/src/presentation/screens/confirm_send/confirm_send_selector.dart';
import 'package:a_wallet/src/presentation/widgets/scroll_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/transaction_box_widget.dart';

class ConfirmSendScreenMessageFormWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final VoidCallback onChangeIsShowedMsg;
  final String amount;
  final String tokenName;
  final String recipient;
  final AppNetworkType networkType;

  const ConfirmSendScreenMessageFormWidget({
    required this.appTheme,
    required this.localization,
    required this.onChangeIsShowedMsg,
    required this.amount,
    required this.tokenName,
    required this.recipient,
    required this.networkType,
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
                LanguageKey.confirmSendScreenMessages,
              ),
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onChangeIsShowedMsg,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AssetIconPath.icCommonConfirmViewMessage,
                  ),
                  const SizedBox(
                    width: BoxSize.boxSize04,
                  ),
                  ConfirmSendIsShowedFullMessageSelector(
                    builder: (isShowedMsg) {
                      final style = AppTypoGraPhy.textSmMedium.copyWith(
                        color: appTheme.textBrandPrimary,
                      );
                      if (isShowedMsg) {
                        return Text(
                          localization.translate(
                            LanguageKey.confirmSendScreenViewCompile,
                          ),
                          style: style,
                        );
                      }
                      return Text(
                        localization.translate(
                          LanguageKey.confirmSendScreenViewData,
                        ),
                        style: style,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        TransactionBoxWidget(
          appTheme: appTheme,
          child: ConfirmSendIsShowedFullMessageSelector(
            builder: (isShowedMsg) {
              if (isShowedMsg) {
                return ScrollBarWidget(
                  appTheme: appTheme,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: BoxSize.boxSize15,
                      minHeight: BoxSize.boxSize13,
                    ),
                    child: SingleChildScrollView(
                      child: ConfirmSendMsgSelector(
                        builder: (msg) {
                          return Text(
                            prettyJson(msg),
                            style: AppTypoGraPhy.textSmMedium.copyWith(
                              color: appTheme.textPrimary,
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                );
              }
              return Row(
                children: [
                  SvgPicture.asset(
                    AssetIconPath.icCommonSignMessage,
                  ),
                  const SizedBox(
                    width: BoxSize.boxSize04,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.translate(
                            LanguageKey.confirmSendScreenSend,
                          ),
                          style: AppTypoGraPhy.textSmBold.copyWith(
                            color: appTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: BoxSize.boxSize03,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: localization.translate(
                                  LanguageKey.confirmSendScreenSend,
                                ),
                                style: AppTypoGraPhy.textSmMedium.copyWith(
                                  color: appTheme.textTertiary,
                                ),
                              ),
                              TextSpan(
                                text: ' [$amount] [$tokenName] ',
                                style: AppTypoGraPhy.textSmMedium.copyWith(
                                  color: appTheme.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text: localization.translate(
                                  LanguageKey.confirmSendScreenTo,
                                ),
                                style: AppTypoGraPhy.textSmMedium.copyWith(
                                  color: appTheme.textTertiary,
                                ),
                              ),
                              TextSpan(
                                text: ' [${recipient.addressView}]',
                                style: AppTypoGraPhy.textSmMedium.copyWith(
                                  color: appTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

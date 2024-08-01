import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/screens/transaction_result/widgets/transaction_infomation.dart';
import 'widgets/button_form.dart';
import 'widgets/logo.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class TransactionResultScreen extends StatefulWidget {
  final String from;
  final String to;
  final String time;
  final String hash;
  final String amount;

  const TransactionResultScreen({
    required this.time,
    required this.amount,
    required this.from,
    required this.hash,
    required this.to,
    super.key,
  });

  @override
  State<TransactionResultScreen> createState() =>
      _TransactionResultScreenState();
}

class _TransactionResultScreenState extends State<TransactionResultScreen>
    with StateFulBaseScreen {
  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  Widget buildSpace(BuildContext context, AppTheme appTheme, AppLocalizationManager localization) {
    return child(context, appTheme, localization);
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TransactionResultLogoWidget(
                  appTheme: appTheme,
                  localization: localization,
                  amount: widget.amount,
                ),
                Padding(
                  padding: defaultPadding(),
                  child: TransactionResultInformationWidget(
                    from: widget.from,
                    recipient: widget.to,
                    appTheme: appTheme,
                    localization: localization,
                    hash: widget.hash,
                    time: widget.time,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: defaultPadding(),
          child: Column(
            children: [
              TransactionResultButtonFormWidget(
                appTheme: appTheme,
                localization: localization,
              ),
              const SizedBox(
                height: BoxSize.boxSize07,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Scaffold(
      backgroundColor: appTheme.bgPrimary,
      body: child,
    );
  }
}

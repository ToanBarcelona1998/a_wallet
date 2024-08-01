import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with StateFulBaseScreen {
  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return const Center(
      child: Text("In Development"),
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Scaffold(
      backgroundColor: appTheme.bgPrimary,
      appBar: AppBarDefault(
        appTheme: appTheme,
        localization: localization,
        isLeftActionActive: false,
        title: const Text("History Page"),
      ),
      body: child,
    );
  }
}

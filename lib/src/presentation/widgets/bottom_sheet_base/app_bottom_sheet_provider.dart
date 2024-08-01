import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/navigator.dart';

class AppBottomSheetProvider extends StatelessWidget {
  final Widget child;
  final AppTheme appTheme;

  const AppBottomSheetProvider({
    required this.child,
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: (){
          AppNavigator.pop();
        },
        child: Scaffold(
          backgroundColor: appTheme.alphaBlack70.withOpacity(
            0.7,
          ),
          body: Stack(
            children: [
              Positioned(
                bottom: BoxSize.boxSize0,
                child: GestureDetector(
                  onTap: (){
                    // Don't close this dialog when users click to child widget
                  },
                  child: SizedBox(
                    width: context.w,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> showFullScreenDialog<T>(
    BuildContext context, {
    required Widget child,
    required AppTheme appTheme,
  }) {
    return showGeneralDialog<T>(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AppBottomSheetProvider(
          appTheme: appTheme,
          child: child,
        );
      },
    );
  }
}

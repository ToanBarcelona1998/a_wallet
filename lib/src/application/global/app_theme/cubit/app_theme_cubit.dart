import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';

import 'app_theme_iml.dart';

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit({AppTheme? theme})
      : super(
          theme ?? AppLightTheme(),
        );

  void initTheme() async {}

  void changeTheme(AppTheme theme) {}

  static AppThemeCubit of(BuildContext context) =>
      BlocProvider.of<AppThemeCubit>(context);
}

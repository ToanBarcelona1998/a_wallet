import 'package:flutter/material.dart';

import 'app_global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGlobalCubit extends Cubit<AppGlobalState> {
  AppGlobalCubit()
      : super(
          const AppGlobalState(),
        );

  void changeStatus(AppGlobalStatus status) {
    emit(state.copyWith(
      status: status,
    ));
  }

  static AppGlobalCubit of(BuildContext context) =>
      BlocProvider.of<AppGlobalCubit>(context);
}

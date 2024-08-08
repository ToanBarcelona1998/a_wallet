import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'social_login_yeti_bot_state.dart';

import 'social_login_yeti_bot_cubit.dart';

final class SocialLoginYetiBotIsReadySelector
    extends BlocSelector<SocialLoginYetiBotCubit, SocialLoginYetiBotState, bool> {
  SocialLoginYetiBotIsReadySelector({
    super.key,
    required Widget Function(bool) builder,
  }) : super(
    selector: (state) => state.isReady,
    builder: (context, isReady) => builder(isReady),
  );
}
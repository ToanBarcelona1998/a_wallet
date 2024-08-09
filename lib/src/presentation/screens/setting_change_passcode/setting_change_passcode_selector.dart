import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_change_passcode_cubit.dart';
import 'setting_change_passcode_state.dart';

final class SettingChangePasscodeStatusSelector extends BlocSelector<
    SettingChangePasscodeCubit,
    SettingChangePasscodeState,
    SettingChangePassCodeStatus> {
  SettingChangePasscodeStatusSelector({
    Key? key,
    required Widget Function(SettingChangePassCodeStatus) builder,
  }) : super(
          key: key,
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_passcode_and_biometric_cubit.dart';
import 'setting_passcode_and_biometric_state.dart';

final class SettingPassCodeAndBioMetricAlReadyBioSelector extends BlocSelector<
    SettingPasscodeAndBiometricCubit, SettingPassCodeAndBiometricState, bool> {
  SettingPassCodeAndBioMetricAlReadyBioSelector({
    Key? key,
    required Widget Function(bool) builder,
  }) : super(
          key: key,
          selector: (state) => state.alReadySetBiometric,
          builder: (_, alReadySetBiometric) => builder(alReadySetBiometric),
        );
}

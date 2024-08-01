import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'home_state.dart';

final class HomeActiveAccountSelector
    extends BlocSelector<HomeBloc, HomeState, Account?> {
  HomeActiveAccountSelector({
    super.key,
    required Widget Function(Account?) builder,
  }) : super(
          selector: (state) => state.activeAccount,
          builder: (context, activeAccount) => builder(activeAccount),
        );
}

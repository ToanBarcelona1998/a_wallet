import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_token_bloc.dart';
import 'manage_token_state.dart';

final class ManageTokenTokensSelector
    extends BlocSelector<ManageTokenBloc, ManageTokenState, List<Token>> {
  ManageTokenTokensSelector({
    super.key,
    required Widget Function(List<Token>) builder,
  }) : super(
          selector: (state) => state.tokens,
          builder: (context, tokens) => builder(tokens),
        );
}

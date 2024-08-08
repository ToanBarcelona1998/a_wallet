import 'package:a_wallet/src/core/constants/aura_ecosystem.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_search_event.dart';
import 'browser_search_state.dart';

class BrowserSearchBloc extends Bloc<BrowserSearchEvent, BrowserSearchState> {
  BrowserSearchBloc()
      : super(
           BrowserSearchState(
            systems: AuraEcosystem.auraEcosystems,
          ),
        ){
    on(_onQuery);
  }

  void _onQuery(
    BrowserSearchOnQueryEvent event,
    Emitter<BrowserSearchState> emit,
  ) {
    final List<BookMark> displays = List.empty(
      growable: true,
    );

    if (event.query.isEmpty) {
      displays.addAll(AuraEcosystem.auraEcosystems);
    } else {
      final mapByQuery = AuraEcosystem.auraEcosystems
          .where(
            (system) => system.name.toLowerCase().contains(
              event.query.toLowerCase(),
            ),
          )
          .toList();

      displays.addAll(mapByQuery);
    }

    emit(
      state.copyWith(
        query: event.query,
        systems: displays,
      ),
    );
  }
}

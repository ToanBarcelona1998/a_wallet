import 'package:a_wallet/src/core/constants/aura_ecosystem.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_page_event.dart';
import 'browser_page_state.dart';

class BrowserPageBloc extends Bloc<BrowserPageEvent, BrowserPageState> {
  final BrowserManagementUseCase _browserManagementUseCase;
  final BookMarkUseCase _bookMarkUseCase;

  BrowserPageBloc(
    this._browserManagementUseCase,
    this._bookMarkUseCase,
  ) : super(
          BrowserPageState(
            ecosystems: AuraEcosystem.auraEcosystems,
          ),
        ) {
    on(_onInit);
    on(_onTabChange);
    on(_onDeleteBookMark);
    on(_onRefreshBookMarkEvent);
    on(_onRefreshBrowserEvent);

    add(
      const BrowserPageOnInitEvent(),
    );
  }

  void _onInit(
    BrowserPageOnInitEvent event,
    Emitter<BrowserPageState> emit,
  ) async {
    final browsers = await _browserManagementUseCase.getAll();
    final bookMarks = await _bookMarkUseCase.getAll();

    emit(
      state.copyWith(
        bookMarks: bookMarks,
        tabCount: browsers.length,
      ),
    );
  }

  void _onTabChange(
    BrowserPageOnChangeTabEvent event,
    Emitter<BrowserPageState> emit,
  ) {
    if (event.index != state.currentTab) {
      emit(
        state.copyWith(
          currentTab: event.index,
        ),
      );
    }
  }

  void _onDeleteBookMark(
    BrowserPageOnDeleteBookMarkEvent event,
    Emitter<BrowserPageState> emit,
  ) async {
    final List<BookMark> disPlayBookMarks = List.empty(growable: true);

    disPlayBookMarks.addAll(state.bookMarks);

    disPlayBookMarks.removeWhere((e) => e.id == event.id);

    emit(
      state.copyWith(
        bookMarks: disPlayBookMarks,
      ),
    );

    await _bookMarkUseCase.delete(
      event.id,
    );
  }

  void _onRefreshBookMarkEvent(
    BrowserPageOnRefreshBookMarkEvent event,
    Emitter<BrowserPageState> emit,
  ) async {
    final bookMarks = await _bookMarkUseCase.getAll();

    emit(
      state.copyWith(
        bookMarks: bookMarks,
      ),
    );
  }

  void _onRefreshBrowserEvent(
    BrowserPageOnRefreshTabEvent event,
    Emitter<BrowserPageState> emit,
  ) async {
    final browsers = await _browserManagementUseCase.getAll();

    emit(
      state.copyWith(
        tabCount: browsers.length,
      ),
    );
  }
}

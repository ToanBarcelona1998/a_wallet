import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_event.dart';
import 'browser_state.dart';

class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  final AccountUseCase _auraAccountUseCase;
  final BrowserManagementUseCase _browserManagementUseCase;
  final BookMarkUseCase _bookMarkUseCase;

  BrowserBloc(
    this._auraAccountUseCase,
    this._browserManagementUseCase,
    this._bookMarkUseCase, {
    required String initUrl,
  }) : super(
          BrowserState(
            currentUrl: initUrl,
          ),
        ) {
    on(_onInit);
    on(_onUrlChangeEvent);
    on(_onBookMarkClick);
    on(_onAddNewBrowser);
    on(_onRefreshAccount);
    on(_onReceivedTabManagementResult);
    on(_onCheckBookMark);
  }

  void _onReceivedTabManagementResult(
    BrowserOnReceivedTabResultEvent event,
    Emitter<BrowserState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BrowserStatus.none,
      ),
    );
    // Get browser by id. Just when users opened the tab management screen and chose a tab.
    final browser = await _browserManagementUseCase.get(event.choosingId!);

    if (browser != null) {
      // Update browser
      await _browserManagementUseCase.update(
        UpdateBrowserParameter(
          id: event.choosingId!,
          siteName: getSiteNameFromUrl(event.url),
          isActive: true,
          url: event.url,
        ),
      );
    }

    // Get all browsers
    final browsers = await _browserManagementUseCase.getAll();

    // Update UI
    emit(
      state.copyWith(
        currentUrl: event.url,
        currentBrowser: browser,
        tabCount: browsers.length,
        status: BrowserStatus.addNewBrowserSuccess,
      ),
    );
  }

  void _onCheckBookMark(
    BrowserOnCheckBookMarkEvent event,
    Emitter<BrowserState> emit,
  ) async {
    // Get bookmark by url
    final bookMark = await _bookMarkUseCase.getBookMarkByUrl(event.url);

    // Update UI
    if (bookMark == null) {
      emit(
        state.copyWithBookMarkNull(
          url: event.url,
          canGoNext: event.canGoNext,
        ),
      );
    } else {
      emit(
        state.copyWith(
          currentUrl: event.url,
          bookMark: bookMark,
        ),
      );
    }
  }

  void _onUrlChangeEvent(
    BrowserOnUrlChangeEvent event,
    Emitter<BrowserState> emit,
  ) async {
    // Get current active browser
    Browser? currentBrowser = state.currentBrowser ??
        await _browserManagementUseCase.getActiveBrowser();

    if (currentBrowser != null) {
      // Update active browser with some information.
      // New url , new title , new image path, new logo
      currentBrowser = await _browserManagementUseCase.update(
        UpdateBrowserParameter(
          id: currentBrowser.id,
          url: event.url,
          logo: event.logo ?? currentBrowser.logo,
          siteName: event.title ?? currentBrowser.siteTitle,
          screenShotUri: event.imagePath ?? currentBrowser.screenShotUri,
          isActive: currentBrowser.isActive,
        ),
      );
    }

    // Update UI
    emit(
      state.copyWith(
        currentBrowser: currentBrowser,
        currentUrl: event.url,
      ),
    );
  }

  void _onInit(
    BrowserOnInitEvent event,
    Emitter<BrowserState> emit,
  ) async {
    // Get current active browser or create new
    final activeBrowser = await _getCurrentBrowser(
      url: state.currentUrl,
    );

    // Get all accounts
    final accounts = await _auraAccountUseCase.getAll();

    // Get all browsers
    final browsers = await _browserManagementUseCase.getAll();

    // Update UI
    emit(
      state.copyWith(
        accounts: accounts,
        tabCount: browsers.isEmpty ? 1 : browsers.length,
        currentBrowser: activeBrowser,
        selectedAccount: accounts.firstWhereOrNull(
          (e) => e.index == 0,
        ),
      ),
    );
  }

  void _onBookMarkClick(
    BrowserOnBookMarkClickEvent event,
    Emitter<BrowserState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BrowserStatus.none,
      ),
    );
    // If current bookmark != null. We will delete this bookmark in bookmark database.
    if (state.bookMark != null) {
      await _bookMarkUseCase.delete(
        state.bookMark!.id,
      );

      //Update UI
      emit(
        state.copyWithBookMarkNull(
          status: BrowserStatus.changeBookMarkSuccess,
        ),
      );
    } else {
      // Add new bookmark. It will return a bookmark
      final bookMark = await _bookMarkUseCase.add(
        AddBookMarkParameter(
          logo: event.logo,
          name: event.name,
          url: event.url,
          description: event.description,
        ),
      );

      // Update UI
      emit(
        state.copyWith(
          bookMark: bookMark,
          status: BrowserStatus.changeBookMarkSuccess,
        ),
      );
    }
  }

  void _onAddNewBrowser(
    BrowserOnAddNewBrowserEvent event,
    Emitter<BrowserState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BrowserStatus.none,
      ),
    );
    // Add a new browser
    final activeBrowser = await _browserManagementUseCase.add(
      AddBrowserParameter(
        logo: event.logo,
        siteName: event.siteName,
        url: event.url,
        screenShotUri: event.browserImage,
      ),
    );

    // Get all browsers
    final browsers = await _browserManagementUseCase.getAll();

    // Update UI
    emit(
      state.copyWith(
        tabCount: browsers.length,
        currentBrowser: activeBrowser,
        status: BrowserStatus.addNewBrowserSuccess,
      ),
    );
  }

  void _onRefreshAccount(
    BrowserOnRefreshAccountEvent event,
    Emitter<BrowserState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedAccount: event.selectedAccount,
      ),
    );

    await Future.delayed(const Duration(
      seconds: 2,
    ));

    final accounts = await _auraAccountUseCase.getAll();

    emit(
      state.copyWith(
        accounts: accounts,
        selectedAccount: accounts.firstWhereOrNull(
          (e) => e.index == 0,
        ),
      ),
    );
  }

  Future<Browser> _getCurrentBrowser({
    required String url,
  }) async {
    Browser? activeBrowser = await _browserManagementUseCase.getActiveBrowser();

    activeBrowser ??= await _browserManagementUseCase.add(
      AddBrowserParameter(
        url: url,
        logo: '',
        siteName: getSiteNameFromUrl(url),
        screenShotUri: '',
      ),
    );

    return activeBrowser;
  }

  String getSiteNameFromUrl(String url) {
    final uri = Uri.parse(url);

    return uri.query.isNotEmpty ? uri.query : uri.host;
  }
}

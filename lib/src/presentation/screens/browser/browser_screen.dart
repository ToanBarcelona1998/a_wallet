import 'dart:io';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/helpers/share_network.dart';
import 'package:a_wallet/src/core/observer/browser_page_observer.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/core/utils/debounce.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'browser_state.dart';
import 'browser_event.dart';
import 'browser_bloc.dart';
import 'browser_selector.dart';
import 'widgets/browser_header_widget.dart';
import 'widgets/browser_bottom_navigator_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:screenshot/screenshot.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'widgets/change_account_form_widget.dart';

class BrowserScreen extends StatefulWidget {
  final String initUrl;

  const BrowserScreen({
    required this.initUrl,
    super.key,
  });

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> with StateFulBaseScreen {
  /// Declare a web view controller
  late WebViewController? _webViewController;

  /// Declare a screen shot controller
  late ScreenshotController _screenShotController;

  /// Declare a denounce helper
  late Denounce<String> _denounce;

  /// Declare a favicon. It can be receive after the web view loaded.
  String? favicon;

  /// Declare a preUrl as old url after the url of web view changes.
  String? preUrl;

  /// Declare a default site url
  final String _googleSearchUrl = 'https://www.google.com/search';

  /// Declare a Browser bloc
  late BrowserBloc _bloc;

  /// Get browser page observer instance
  final BrowserPageObserver _browserPageObserver =
      getIt.get<BrowserPageObserver>();

  /// Run script method. It includes the script to get the favicon of website.
  Future<void> _runJavaScript() async {
    return _webViewController?.runJavaScript('''
            var links = document.head.getElementsByTagName('link');
            for (var i = 0; i < links.length; i++) {
              if (links[i].rel == 'icon' || links[i].rel == 'shortcut icon' || links[i].rel == 'apple-touch-icon') {
                favicon.postMessage(links[i].href);
                break;
              }
            }
          ''');
  }

  /// On web view changes url
  void _onUrlChange(UrlChange change) async {
    // Set favicon = null
    favicon = null;
    // Check PreUrl and url changes. If they are the same. Doesn't handle function
    if (change.url == preUrl) return;

    // Check web view can go next
    final bool canGoNext = await _webViewController?.canGoForward() ?? false;

    // Call check book mark.
    _bloc.add(
      BrowserOnCheckBookMarkEvent(
        url: change.url ?? widget.initUrl,
        canGoNext: canGoNext,
      ),
    );

    // Set preUrl = url changes
    preUrl = change.url;

    // Run denounce observer
    _denounce.onDenounce(
      change.url ?? widget.initUrl,
    );
  }

  /// Screenshot current web view page.
  Future<String?> _screenShot() async {
    final currentBrowser = _bloc.state.currentBrowser;

    if (currentBrowser != null) {
      // Get a wallet application directory
      final directory = await getApplicationDocumentsDirectory();

      File file = File(currentBrowser.screenShotUri);

      // Check file exists
      if (await file.exists()) {
        // Delete file
        await file.delete();
      }

      if (context.mounted) {
        // Capture current web view page and save return a image path
        return _screenShotController.captureAndSave(
          directory.path,
          pixelRatio: context.ratio,
          fileName:
              '${currentBrowser.siteTitle.replaceAll(' ', '')}_${currentBrowser.id}',
        );
      }
    }

    // return default
    return null;
  }

  /// Init web view controller
  WebViewController _initWebViewController() {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            favicon = null;
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: _onUrlChange,
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..addJavaScriptChannel(
        'favicon',
        onMessageReceived: (JavaScriptMessage message) {
          // receive favicon
          favicon = message.message;
        },
      );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    // return controller
    return controller;
  }

  /// Handle url changes. It will update current browser
  void _urlChangeObserver(String url) async {
    // Run script get favicon
    await _runJavaScript();

    // Get current web view title
    final String? title = await _webViewController?.getTitle();

    // Get web view screenshot image path
    final String? path = await _screenShot();

    // Call update in bloc.
    _bloc.add(
      BrowserOnUrlChangeEvent(
        url: url,
        title: title,
        logo: favicon,
        imagePath: path,
      ),
    );
  }

  @override
  EdgeInsets? padding() {
    return EdgeInsets.zero;
  }

  @override
  void initState() {
    // Give a instance of denounce and register an observer
    _denounce = Denounce(
      const Duration(
        seconds: 3,
      ),
    )..addObserver(_urlChangeObserver);

    // create a instance of bloc. Passes two parameters
    _bloc = getIt.get<BrowserBloc>(
      param1: widget.initUrl,
    );

    // Call init event
    _bloc.add(
      const BrowserOnInitEvent(),
    );

    // init web view controller
    _webViewController = _initWebViewController();

    // load default request by init url
    _webViewController?.loadRequest(
      Uri.parse(
        widget.initUrl,
      ),
    );

    _screenShotController = ScreenshotController();
    super.initState();
  }

  @override
  void dispose() {
    // Remove observer
    _denounce.removeObserver(_urlChangeObserver);
    _denounce.disPose();
    super.dispose();
  }
  /// On users click book mark
  void _onBookMarkClick() async {
    // Get current site url
    final String? url = await _webViewController?.currentUrl();

    // Get current site title
    String? title = await _webViewController?.getTitle();

    if (title == null) {
      final Uri uri = Uri.parse(url ?? widget.initUrl);

      title = uri.query.isNotEmpty ? uri.query : uri.host;
    }

    // Call update in bloc
    _bloc.add(
      BrowserOnBookMarkClickEvent(
        name: title,
        url: url ?? widget.initUrl,
        logo: favicon ?? '',
      ),
    );
  }

  /// On users click home
  void _onHomeClick() {
    // return to home page.
    AppNavigator.popUntil(
      RoutePath.home,
    );
  }

  /// On users click next
  void _onNextClick() async {
    // Check current web view can go next
    final canGoForward = await _webViewController?.canGoForward() ?? false;
    if (canGoForward) {
      // Go next
      await _webViewController?.goForward();
    }
  }

  /// On users click back
  void _onBackClick() async {
    // Check current web view can go back
    final canGoBack = await _webViewController?.canGoBack() ?? false;
    if (canGoBack) {
      // Go back
      await _webViewController?.goBack();
    } else {
      // If not. Back to pre page
      AppNavigator.pop();
    }
  }

  /// On users click share
  void _onShareBrowserPage() async {
    // Get current web view url
    final url = await _webViewController?.currentUrl();

    // Call share method
    await ShareNetWork.shareUri(
      url ?? widget.initUrl,
    );
  }

  /// On users click add new tab
  void _onAddNewTab() async {
    // Call add new site
    _bloc.add(
      BrowserOnAddNewBrowserEvent(
        url: _googleSearchUrl,
        siteName: _bloc.getSiteNameFromUrl(
          _googleSearchUrl,
        ),
        logo: '',
        browserImage: '',
      ),
    );

    // Set current web view = null. It is required to refresh a page.
    setState(() {
      _webViewController = null;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {
      // Init web view
      _webViewController = _initWebViewController();
    });

    // Load new request
    _webViewController?.loadRequest(
      Uri.parse(
        _googleSearchUrl,
      ),
    );
  }

  /// On users click refresh current site.
  void _onRefreshPage() async {
    // Call reload
    await _webViewController?.reload();
  }

  /// On users click view tab management
  void _onViewTabManagement() async {
    // Push to browser tab management screen with parameter
    final Map<String, dynamic>? result = await AppNavigator.push(
      RoutePath.browserTabManagement,
      false,
    );

    if (result != null) {
      final int? id = result['id'];

      final String url = result['url'];

      if (id != null && id == _bloc.state.currentBrowser?.id) return;

      // Call update
      _bloc.add(
        BrowserOnReceivedTabResultEvent(
          url: url,
          choosingId: id,
        ),
      );

      setState(() {
        // Set current web view = null. It is required to refresh a page.
        _webViewController = null;
      });

      await Future.delayed(
        const Duration(seconds: 1),
      );

      setState(() {
        // Init web view
        _webViewController = _initWebViewController();
      });

      // Load request
      _webViewController?.loadRequest(
        Uri.parse(
          url,
        ),
      );
    }
  }

  /// Call refresh book mark in browser page
  void _onRefreshBookMarkBrowserPage() {
    _browserPageObserver.emit(
      emitParam: const BrowserPageEmitParam(
        event: BrowserPageObserver.onInAppBrowserRefreshBookMarkEvent,
      ),
    );
  }

  /// Call refresh tab in browser page
  void _onRefreshTabBrowserPage() {
    _browserPageObserver.emit(
      emitParam: const BrowserPageEmitParam(
        event: BrowserPageObserver.onInAppBrowserRefreshBrowserEvent,
      ),
    );
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return Column(
      children: [
        Padding(
          padding: defaultPadding(),
          child: BrowserUrlSelector(
            builder: (url) {
              return BrowserScreenHeaderWidget(
                appTheme: appTheme,
                onViewTap: _onViewTabManagement,
                onSearchTap: () {},
                url: url,
                onRefresh: _onRefreshPage,
                onAddNewTab: _onAddNewTab,
                onShareTap: _onShareBrowserPage,
                localization: localization,
              );
            },
          ),
        ),
        Expanded(
          child: Screenshot(
            controller: _screenShotController,
            child: _webViewController != null
                ? WebViewWidget(
                    controller: _webViewController!,
                  )
                : Center(
                    child: AppLoadingWidget(
                      appTheme: appTheme,
                    ),
                  ),
          ),
        ),
        BrowserScreenBottomNavigatorWidget(
          appTheme: appTheme,
          onBack: _onBackClick,
          onBookmarkClick: _onBookMarkClick,
          onNext: _onNextClick,
          onHomeClick: _onHomeClick,
          onAccountClick: (accounts, selectedAccount) {

          },
        )
      ],
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<BrowserBloc, BrowserState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case BrowserStatus.none:
              break;
            case BrowserStatus.changeBookMarkSuccess:
              _onRefreshBookMarkBrowserPage();
              break;
            case BrowserStatus.addNewBrowserSuccess:
              _onRefreshTabBrowserPage();
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          body: child,
        ),
      ),
    );
  }
}

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/app_configs/a_wallet_config.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/observer/home_page_observer.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/navigator.dart';
import 'home_page_selector.dart';
import 'widgets/app_bar.dart';
import 'widgets/nft.dart';
import 'home_page_event.dart';
import 'widgets/action.dart';
import 'widgets/story.dart';
import 'widgets/tab.dart';
import 'widgets/token.dart';
import 'widgets/wallet.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';

import 'home_page_bloc.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onReceivedTap;

  const HomePage({
    required this.onReceivedTap,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with StateFulBaseScreen, SingleTickerProviderStateMixin {
  final HomePageObserver _homePageObserver = getIt.get<HomePageObserver>();

  late HomePageBloc _bloc;

  final String avatarAsset = randomAvatar();

  /// Region declare controller
  final AWalletConfig _config = getIt.get<AWalletConfig>();
  late TabController _controller;
  late PageController _pageController;

  late ScrollController _scrollController;

  /// Endregion

  ///Region init animation card
  final Duration _animatedDuration = const Duration(
    milliseconds: 300,
  );

  final GlobalKey _walletActionKey = GlobalKey();
  double _walletActionOffset = 0;

  final GlobalKey _walletCardKey = GlobalKey();
  double _walletCardOffset = 0;

  double _scrollPosition = 0;
  double _walletCardScale = 1.0;
  double _walletCardOpacity = 1.0;

  double paddingTop = 0;

  bool _showWalletCard = false;
  bool _showActions = false;

  ///endregion

  void _createScrollController() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _disposeController() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    _scrollPosition = _scrollController.offset;

    setState(
      () {
        _detectScrollOverWalletCard();
        _detectScrollOverAction();
      },
    );
  }

  void _detectScrollOverAction() {
    if (_walletActionOffset == 0) {
      final RenderBox? renderBox =
          _walletActionKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        Offset position = renderBox.localToGlobal(Offset.zero);
        _walletActionOffset =
            position.dy + 0.5 * renderBox.size.height - kToolbarHeight;
      }
    }

    if (_scrollPosition + kToolbarHeight + paddingTop >= _walletActionOffset) {
      _showActions = true;
    } else {
      _showActions = false;
    }
  }

  void _detectScrollOverWalletCard() {
    if (_walletCardOffset == 0) {
      final RenderBox? renderBox =
          _walletCardKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        Offset position = renderBox.localToGlobal(Offset.zero);
        _walletCardOffset =
            position.dy + 0.85 * renderBox.size.height - kToolbarHeight;
      }
    }

    if (_scrollPosition < _walletCardOffset) {
      _walletCardScale = 1 - (_scrollPosition / _walletCardOffset);

      _walletCardOpacity = 1 - (_scrollPosition / _walletCardOffset);
    }

    _walletCardScale = _walletCardScale.clamp(0.0, 1.0);

    _walletCardOpacity = _walletCardOpacity.clamp(0.0, 1.0);

    if (_scrollPosition + kToolbarHeight + paddingTop >= _walletCardOffset) {
      _showWalletCard = true;
    } else {
      _showWalletCard = false;
    }
  }

  @override
  void initState() {
    _bloc = getIt.get<HomePageBloc>(
      param1: _config,
    );
    _controller = TabController(length: 2, vsync: this);

    _pageController = PageController();
    _createScrollController();

    _homePageObserver.addListener(_homePageListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _disposeController();
    _homePageObserver.removeListener(_homePageListener);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    paddingTop = context.statusBar;
    super.didChangeDependencies();
  }

  void _homePageListener(HomePageEmitParam param) {
    final String event = param.event;
    final data = param.data;

    LogProvider.log('Home page\n Receive event: $event');

    switch (event) {
      case HomePageObserver.onSendTokenDone:
        // Refresh balance home page
        break;
      case HomePageObserver.onSendNFTDone:
        // Refresh balance home page
        break;
      case HomePageObserver.onChangeAccount:
        break;
      default:
        break;
    }
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: context.bodyHeight, maxHeight: context.bodyHeight * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: _walletCardOpacity,
              duration: _animatedDuration,
              key: _walletCardKey,
              child: Transform.scale(
                scale: _walletCardScale,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HomePageStoryWidget(
                          thumbnail:
                              'https://cdn.pixabay.com/photo/2022/11/30/20/48/turtle-7627773_1280.jpg',
                          title: 'Create passcode',
                          appTheme: appTheme,
                        ),
                        const SizedBox(
                          width: BoxSize.boxSize05,
                        ),
                        HomePageStoryWidget(
                          thumbnail:
                              'https://cdn.pixabay.com/photo/2022/11/30/20/48/turtle-7627773_1280.jpg',
                          title: 'Punka event',
                          appTheme: appTheme,
                        ),
                        const SizedBox(
                          width: BoxSize.boxSize05,
                        ),
                        HomePageStoryWidget(
                          thumbnail:
                              'https://cdn.pixabay.com/photo/2022/11/30/20/48/turtle-7627773_1280.jpg',
                          title: 'Create passcode',
                          appTheme: appTheme,
                        ),
                        const SizedBox(
                          width: BoxSize.boxSize05,
                        ),
                        HomePageStoryWidget(
                          thumbnail:
                              'https://cdn.pixabay.com/photo/2022/11/30/20/48/turtle-7627773_1280.jpg',
                          title: 'Punka event',
                          appTheme: appTheme,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: BoxSize.boxSize07,
                    ),
                    HomePageWalletCardWidget(
                      appTheme: appTheme,
                      localization: localization,
                      onEnableTokenTap: _onEnableTokenTap,
                      avatarAsset: avatarAsset,
                    )
                  ],
                ),
              ),
            ),
            Column(
              key: _walletActionKey,
              children: [
                const SizedBox(
                  height: BoxSize.boxSize07,
                ),
                HomePageActiveAccountSelector(
                  builder: (account) {
                    return HomePageActionsWidget(
                      appTheme: appTheme,
                      localization: localization,
                      onSendTap: _onSendTap,
                      onReceiveTap: _onReceiveTap,
                      onStakingTap: _onStakingTap,
                      onSwapTap: _onSwapTap,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: BoxSize.boxSize05,
            ),
            HomePageTabWidget(
              appTheme: appTheme,
              localization: localization,
              controller: _controller,
              onSelected: _onChangeTab,
            ),
            const SizedBox(
              height: BoxSize.boxSize05,
            ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                onPageChanged: _onChangePage,
                controller: _pageController,
                children: [
                  HomePageTokensWidget(
                    appTheme: appTheme,
                    localization: localization,
                    config: _config,
                  ),
                  HomePageNFTsWidget(
                    appTheme: appTheme,
                    localization: localization,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: appTheme.bgPrimary,
        appBar: AppBarDefault(
          appTheme: appTheme,
          localization: localization,
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          title: HomePageActiveAccountSelector(
            builder: (account) {
              return HomeAppBar(
                appTheme: appTheme,
                localization: localization,
                onActionClick: _onActionClick,
                showActions: _showActions,
                showWallet: _showWalletCard,
                avatarAsset: avatarAsset,
                onSendTap: _onSendTap,
                onReceiveTap: _onReceiveTap,
                onStakingTap: _onStakingTap,
                onSwapTap: _onSwapTap,
              );
            },
          ),
        ),
        body: child,
      ),
    );
  }

  void _onActionClick() {
    _scrollController.animateTo(
      0,
      duration: _animatedDuration,
      curve: Curves.easeOut,
    );
  }

  void _onChangePage(int page) {
    _controller.animateTo(
      page,
      duration: _animatedDuration,
      curve: Curves.ease,
    );
  }

  void _onChangeTab(int page) {
    _pageController.animateToPage(
      page,
      duration: _animatedDuration,
      curve: Curves.ease,
    );
  }

  void _onEnableTokenTap() {
    _bloc.add(
      const HomePageOnUpdateEnableTotalTokenEvent(),
    );
  }

  void _onSendTap() {
    AppNavigator.push(RoutePath.send);
  }

  void _onReceiveTap() {
    widget.onReceivedTap();
  }

  void _onSwapTap() {}

  void _onStakingTap() {}
}

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme_builder.dart';
import 'package:a_wallet/src/application/global/localization/app_localization_provider.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/helpers/share_network.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/core/utils/copy.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'package:a_wallet/src/navigator.dart';
import 'home_selector.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'package:a_wallet/src/presentation/widgets/select_network_widget.dart';

import 'widgets/bottom_navigator_bar_widget.dart';
import 'widgets/receive_token.dart';
import 'widgets/tab_builder.dart';

enum HomeScreenSection {
  wallet,
  browser,
  home,
  history,
  setting,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, CustomFlutterToast, Copy {
  late HomeScreenSection currentSection;
  late AnimationController _receiveWidgetController;
  late Animation _receiveAnimation;

  final HomeBloc _bloc = getIt.get<HomeBloc>();

  late AppNetwork appNetwork;

  @override
  void initState() {
    appNetwork = getIt.get<List<AppNetwork>>()[0];
    currentSection = HomeScreenSection.home;
    _receiveWidgetController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    );

    _bloc.add(
      const HomeOnInitEvent(),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _receiveAnimation = Tween<double>(
      begin: -context.h,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _receiveWidgetController,
        curve: Curves.easeOutSine,
      ),
    );
  }

  void _onReceiveTap(
    Account account,
    List<AppNetwork> networks,
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) {
    // Show all
    if (networks.length == 2) {
      AppBottomSheetProvider.showFullScreenDialog(
        context,
        child: SelectNetworkAccountReceiveWidget(
          appTheme: appTheme,
          localization: localization,
          networks: networks,
          account: account,
          onShowQr: (account, network) {
            AppNavigator.pop();
            appNetwork = network;

            setState(() {

            });
            _receiveWidgetController.forward();
          },
          onCopy: (address) {
            AppNavigator.pop();
            _onCopy(address);
          },
        ),
        appTheme: appTheme,
      );
    } else {}
  }

  void _onCopy(String address) {
    copy(address);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: _bloc,
        child: AppThemeBuilder(
          builder: (appTheme) {
            return AppLocalizationProvider(
              builder: (localization) {
                return Stack(
                  children: [
                    Scaffold(
                      body: SafeArea(
                        child: HomeScreenTabBuilder(
                          currentSection: currentSection,
                          onReceivedTap: _onReceiveTap,
                        ),
                      ),
                      bottomNavigationBar: BottomNavigatorBarWidget(
                        currentIndex: HomeScreenSection.values.indexOf(
                          currentSection,
                        ),
                        appTheme: appTheme,
                        onTabSelect: (index) {
                          // Handle tab selection and update the current section
                          final HomeScreenSection newSection =
                              HomeScreenSection.values[index];

                          if (currentSection == newSection) {
                            return;
                          }
                          setState(
                            () {
                              currentSection = newSection;
                            },
                          );
                        },
                        localization: localization,
                      ),
                    ),
                    // AnimatedBuilder for receiving widget animation
                    AnimatedBuilder(
                      animation: _receiveWidgetController,
                      child: HomeActiveAccountSelector(
                        builder: (account) {
                          return ReceiveTokenWidget(
                            network: appNetwork,
                            account: account,
                            theme: appTheme,
                            localization: localization,
                            onSwipeUp: () async {
                              // Reverse the animation when the widget is swiped up
                              if (_receiveWidgetController.isCompleted) {
                                await _receiveWidgetController.reverse();
                                _receiveWidgetController.reset();
                              }
                            },
                            onShareAddress:_onShareAddress,
                            onCopyAddress: _onCopy,
                            onDownload: () {
                              
                            },
                          );
                        }
                      ),
                      // Apply translation to the child based on the animation value
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            _receiveAnimation.value,
                          ),
                          child: child ?? const SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onShareAddress(String address){
    ShareNetWork.shareText(address);
  }
}

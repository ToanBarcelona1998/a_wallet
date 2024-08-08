import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/base_screen.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/app_configs/di.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/toast.dart';
import 'widgets/update_address_book_widget.dart';
import 'widgets/add_address_book_widget.dart';
import 'widgets/address_book_detail_form_widget.dart';
import 'widgets/address_book_widget.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/app_loading_widget.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'address_book_event.dart';
import 'package:a_wallet/src/presentation/widgets/app_bar_widget.dart';

import 'address_book_bloc.dart';
import 'address_book_state.dart';
import 'address_book_selector.dart';

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen>
    with CustomFlutterToast, StateFulBaseScreen {
  final AddressBookBloc _bloc = getIt.get<AddressBookBloc>();

  @override
  void initState() {
    _bloc.add(
      const AddressBookOnFetchEvent(),
    );
    super.initState();
  }

  void _onAdded() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    if (context.mounted) {
      showSuccessToast(
        AppLocalizationManager.of(context).translate(
          LanguageKey.addressBookScreenAddContactAdded,
        ),
      );
    }
  }

  void _onEdited() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    if (context.mounted) {
      showSuccessToast(
        AppLocalizationManager.of(context).translate(
          LanguageKey.addressBookScreenEditContactEdited,
        ),
      );
    }
  }

  void _onExists() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    if (context.mounted) {
      showToast(
        AppLocalizationManager.of(context).translate(
          LanguageKey.addressBookScreenExist,
        ),
      );
    }
  }

  void _showAddForm(
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) {
    AppBottomSheetProvider.showFullScreenDialog(
      context,
      appTheme: appTheme,
      child: AddressBookAddWidget(
        onConfirm: (address, name) {
          _bloc.add(
            AddressBookOnAddEvent(
              name: name,
              address: address,
            ),
          );
        },
        appTheme: appTheme,
        localization: localization,
      ),
    );
  }

  void _showDetailForm(
    AppTheme appTheme,
    AppLocalizationManager localization,
    AddressBook addressBook,
  ) {
    AppBottomSheetProvider.showFullScreenDialog(
      context,
      appTheme: appTheme,
      child: AddressBookDetailFormWidget(
        appTheme: appTheme,
        name: addressBook.name,
        address: addressBook.address,
        onEdit: () {
          AppNavigator.pop();
          _showUpdateForm(
            addressBook,
            appTheme,
            localization,
          );
        },
        onRemove: () {
          AppNavigator.pop();
          _bloc.add(
            AddressBookOnDeleteEvent(
              id: addressBook.id,
            ),
          );
        },
        localization: localization,
      ),
    );
  }

  void _showUpdateForm(
    AddressBook addressBook,
    AppTheme appTheme,
    AppLocalizationManager localization,
  ) {
    AppBottomSheetProvider.showFullScreenDialog(
      context,
      appTheme: appTheme,
      child: AddressBookUpdateWidget(
        appTheme: appTheme,
        localization: localization,
        onConfirm: (address, name) {
          _bloc.add(
            AddressBookOnUpdateEvent(
              id: addressBook.id,
              name: name,
              address: address,
            ),
          );
        },
        name: addressBook.name,
        address: addressBook.address,
      ),
    );
  }

  @override
  Widget child(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return AddressBookStatusSelector(
      builder: (status) {
        switch (status) {
          case AddressBookStatus.loading:
            return Center(
              child: AppLoadingWidget(
                appTheme: appTheme,
              ),
            );
          case AddressBookStatus.loaded:
          case AddressBookStatus.error:
          case AddressBookStatus.edited:
          case AddressBookStatus.removed:
          case AddressBookStatus.added:
          case AddressBookStatus.exists:
            return Column(
              children: [
                Expanded(
                  child: AddressBookContactsSelector(
                    builder: (contacts) {
                      if (contacts.isEmpty) {
                        return Center(
                          child: Text(
                            localization.translate(
                              LanguageKey.addressBookScreenEmptyContact,
                            ),
                            style: AppTypoGraPhy.textSmMedium.copyWith(
                              color: appTheme.textSecondary,
                            ),
                          ),
                        );
                      }
                      return CombinedListView(
                        onRefresh: () {
                          //
                        },
                        onLoadMore: () {
                          //
                        },
                        data: contacts,
                        builder: (contact, _) {
                          return AddressBookWidget(
                            name: contact.name,
                            address: contact.address,
                            appTheme: appTheme,
                            key: ValueKey(
                              contact,
                            ),
                            onTap: () {
                              _showDetailForm(
                                appTheme,
                                localization,
                                contact,
                              );
                            },
                          );
                        },
                        canLoadMore: false,
                      );
                    },
                  ),
                ),
                PrimaryAppButton(
                  leading: SvgPicture.asset(
                    AssetIconPath.icCommonAdd,
                  ),
                  text: localization.translate(
                    LanguageKey.addressBookScreenAddContact,
                  ),
                  onPress: () => _showAddForm(appTheme, localization),
                ),
              ],
            );
        }
      },
    );
  }

  @override
  Widget wrapBuild(BuildContext context, Widget child, AppTheme appTheme,
      AppLocalizationManager localization) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<AddressBookBloc, AddressBookState>(
        listener: (context, state) async {
          switch (state.status) {
            case AddressBookStatus.loading:
              break;
            case AddressBookStatus.loaded:
              break;
            case AddressBookStatus.error:
              break;
            case AddressBookStatus.exists:
              _onExists();
              break;
            case AddressBookStatus.added:
              _onAdded();
              break;
            case AddressBookStatus.edited:
              _onEdited();
              break;
            case AddressBookStatus.removed:
              break;
          }
        },
        child: Scaffold(
          backgroundColor: appTheme.bgPrimary,
          appBar: AppBarDefault(
            localization: localization,
            appTheme: appTheme,
            titleKey: LanguageKey.addressBookScreenAppBarTitle,
          ),
          body: child,
        ),
      ),
    );
  }
}

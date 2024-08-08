import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_book_bloc.dart';
import 'address_book_state.dart';

class AddressBookStatusSelector
    extends BlocSelector<AddressBookBloc, AddressBookState, AddressBookStatus> {
  AddressBookStatusSelector({
    Key? key,
    required Widget Function(AddressBookStatus status) builder,
  }) : super(
          key: key,
          builder: (_, status) => builder(
            status,
          ),
          selector: (state) => state.status,
        );
}

class AddressBookContactsSelector
    extends BlocSelector<AddressBookBloc, AddressBookState, List<AddressBook>> {
  AddressBookContactsSelector({
    Key? key,
    required Widget Function(List<AddressBook> contacts) builder,
  }) : super(
          key: key,
          builder: (_, contacts) => builder(
            contacts,
          ),
          selector: (state) => state.addressBooks,
        );
}

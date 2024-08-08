import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'address_book_event.dart';

import 'address_book_state.dart';

class AddressBookBloc extends Bloc<AddressBookEvent, AddressBookState> {
  final AddressBookUseCase _addressBookUseCase;

  AddressBookBloc(this._addressBookUseCase)
      : super(
          const AddressBookState(),
        ) {
    on(_onFetch);
    on(_onUpdate);
    on(_onAdd);
    on(_onDelete);
  }

  void _onFetch(
    AddressBookOnFetchEvent event,
    Emitter<AddressBookState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AddressBookStatus.loading,
      ),
    );
    try {
      final addressBooks = await _addressBookUseCase.getAll();

      emit(
        state.copyWith(
          addressBooks: addressBooks,
          status: AddressBookStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressBookStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void _onUpdate(
    AddressBookOnUpdateEvent event,
    Emitter<AddressBookState> emit,
  ) async {
    final List<AddressBook> addressBooks = List.empty(growable: true)
      ..addAll(state.addressBooks);

    int index = addressBooks.indexWhere(
      (e) => e.id == event.id,
    );

    if (index != -1) {
      addressBooks.removeAt(index);

      final addressBook = await _addressBookUseCase.update(
        UpdateAddressBookRequest(
          id: event.id,
          address: event.address,
          name: event.name,
        ),
      );

      addressBooks.insert(
        index,
        addressBook,
      );

      emit(
        state.copyWith(
          addressBooks: addressBooks,
          status: AddressBookStatus.edited,
        ),
      );
    }
  }

  void _onAdd(
    AddressBookOnAddEvent event,
    Emitter<AddressBookState> emit,
  ) async {
    final List<AddressBook> addressBooks = List.empty(growable: true)
      ..addAll(state.addressBooks);

    bool isExists = state.addressBooks
            .firstWhereOrNull((e) => e.address == event.address) !=
        null;

    if (isExists) {
      emit(
        state.copyWith(
          addressBooks: addressBooks,
          status: AddressBookStatus.exists,
        ),
      );
    } else {
      final addressBook = await _addressBookUseCase.add(
        AddAddressBookRequest(
          address: event.address,
          name: event.name,
        ),
      );

      addressBooks.add(
        addressBook,
      );

      emit(
        state.copyWith(
          addressBooks: addressBooks,
          status: AddressBookStatus.added,
        ),
      );
    }
  }

  void _onDelete(
    AddressBookOnDeleteEvent event,
    Emitter<AddressBookState> emit,
  ) async {
    final List<AddressBook> addressBooks = List.empty(growable: true)
      ..addAll(state.addressBooks);

    addressBooks.removeWhere((e) => e.id == event.id);

    await _addressBookUseCase.delete(
      event.id,
    );

    emit(
      state.copyWith(
        addressBooks: addressBooks,
        status: AddressBookStatus.removed,
      ),
    );
  }
}

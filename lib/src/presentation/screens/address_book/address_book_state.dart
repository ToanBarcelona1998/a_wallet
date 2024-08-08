import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_book_state.freezed.dart';

enum AddressBookStatus {
  loading,
  loaded,
  error,
  edited,
  added,
  removed,
  exists,
}

@freezed
class AddressBookState with _$AddressBookState {
  const factory AddressBookState({
    @Default(AddressBookStatus.loading) AddressBookStatus status,
    @Default([]) List<AddressBook> addressBooks,
    String ?error,
  }) = _AddressBookState;
}

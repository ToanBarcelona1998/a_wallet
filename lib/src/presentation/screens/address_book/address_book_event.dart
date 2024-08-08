import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_book_event.freezed.dart';

@freezed
class AddressBookEvent with _$AddressBookEvent {
  const factory AddressBookEvent.fetch() = AddressBookOnFetchEvent;

  const factory AddressBookEvent.onEdit({
    required String name,
    required String address,
    required int id,
  }) = AddressBookOnUpdateEvent;

  const factory AddressBookEvent.onAdd({
    required String name,
    required String address,
  }) = AddressBookOnAddEvent;

  const factory AddressBookEvent.onDelete({
    required int id,
  }) = AddressBookOnDeleteEvent;
}

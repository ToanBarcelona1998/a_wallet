import 'package:a_wallet/src/core/helpers/address_validator.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nft_transfer_event.dart';
import 'nft_transfer_state.dart';

final class NftTransferBloc extends Bloc<NftTransferEvent, NftTransferState> {
  final AccountUseCase _accountUseCase;
  final AddressBookUseCase _addressBookUseCase;

  NftTransferBloc(this._accountUseCase, this._addressBookUseCase)
      : super(
          const NftTransferState(),
        ){
    on(_onInit);
    on(_onChangeTo);
  }

  void _onInit(
    NftTransferOnInitEvent event,
    Emitter<NftTransferState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: NftTransferStatus.loading,
      ));

      final account = await _accountUseCase.getFirstAccount();

      emit(state.copyWith(
        account: account,
        status: NftTransferStatus.loaded,
      ));

      final addressBooks = await _addressBookUseCase.getAll();

      emit(state.copyWith(
        addressBooks: addressBooks,
        status: NftTransferStatus.loaded,
      ));
    } catch (e) {
      LogProvider.log('Nft transfer on init error ${e.toString()}');
      emit(state.copyWith(
        status: NftTransferStatus.error,
      ));
    }
  }

  void _onChangeTo(
    NftTransferOnChangeToEvent event,
    Emitter<NftTransferState> emit,
  ) {
    emit(
      state.copyWith(
        toAddress: event.address,
        already: addressInValid(
          address: event.address,
        ),
      ),
    );
  }
}

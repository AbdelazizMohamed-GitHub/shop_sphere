// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/repo/address_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.addressRepo,
  }) : super(AdressInitial());
  final AddressRepo addressRepo;
  Future<void> addAddress(
      {required String addressId, required AddressModel addressModel}) async {
    emit(AddressLoading());
    final result = await addressRepo.addAddress(addressId, addressModel);
    result.fold(
      (failure) => emit(AddressError(errMessage: failure.message)),
      (user) async {
        await getAddress();
      },
    );
  }

  Future<void> updateAddress(
      {required String addressId, required AddressModel addressModel}) async {
    emit(AddressLoading());
    final result = await addressRepo.updateAddress(addressId, addressModel);
   
    result.fold((failure) => emit(AddressError(errMessage: failure.message)),
        (user) async {
      await getAddress();
    });
  }

  Future<void> deleteAddress({required String addressId}) async {
    emit(AddressLoading());
    final result = await addressRepo.deleteAddress(addressId);
    result.fold(
      (failure) => emit(AddressError(errMessage: failure.message)),
      (user) async {
        await getAddress();
      },
    );
  }

  Future<void> getAddress() async {
    emit(AddressLoading());
    final result = await addressRepo.getAddress();
    result.fold(
      (failure) => emit(AddressError(errMessage: failure.message)),
      (address) => emit(AddressSuccess(addresses: address)),
    );
  }
  Future<void> updateAddressIndex({required int sellectAddress}) async {
    emit(AddressLoading());
    final result = await addressRepo.updateAddressIndex(
      sellectAddress: sellectAddress,
    );
    result.fold(
      (failure) => emit(AddressError(errMessage: failure.message)),
      (user) async {
        await getAddress();
      },
    );
  }
}

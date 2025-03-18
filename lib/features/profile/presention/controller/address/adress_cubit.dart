// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/features/profile/data/model/addres_model.dart';
import 'package:shop_sphere/features/profile/domain/repo/address_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/address/adress_state.dart';

class AdressCubit extends Cubit<AdressState> {
  AdressCubit({
    required this.addressRepo,
  }) : super(AdressInitial());
  final AddressRepo addressRepo;
  Future<void> addAddress(
      {required String addressId, required AddressModel addressModel}) async {
    emit(AddAdressLoading());
    final result = await addressRepo.addAddress(addressId, addressModel);
    result.fold(
      (failure) => emit(AdressError(errMessage: failure.message)),
      (user) => emit(AddAdressSuccess()),
    );
  }

  Future<void> updateAddress(
      {required String addressId, required AddressModel addressModel}) async {
    emit(AdressLoading());
    final result = await addressRepo.updateAddress(addressId, addressModel);
    result.fold(
      (failure) => emit(AdressError(errMessage: failure.message)),
      (user) => emit(AdressSuccess()),
    );
  }

  Future<void> deleteAddress({required String addressId}) async {
    emit(AdressLoading());
    final result = await addressRepo.deleteAddress(addressId);
    result.fold(
      (failure) => emit(AdressError(errMessage: failure.message)),
      (user) => emit(AdressSuccess()),
    );
  }

  Future<void> getAddress() async {
    emit(GetAdressLoading());
    final result = await addressRepo.getAddress();
    result.fold(
      (failure) => emit(AdressError(errMessage: failure.message)),
      (address) => emit(GetAdressSuccess(addresses: address)),
    );
  }
}

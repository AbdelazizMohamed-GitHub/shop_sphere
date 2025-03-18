


 import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class AddressState {}

 class AdressInitial extends AddressState {}


 class GetAdressLoading extends AddressState {}
 class GetAdressSuccess extends AddressState {
   final List<AddressEntity> addresses;
   GetAdressSuccess({required this.addresses});
 }
 class AdressLoading extends AddressState {}
 class AdressSuccess extends AddressState {}


 class AdressError extends AddressState {
   final String errMessage;

   AdressError({required this.errMessage});
 }

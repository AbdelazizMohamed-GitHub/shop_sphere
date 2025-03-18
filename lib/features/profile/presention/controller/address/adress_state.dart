


 import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class AdressState {}

 class AdressInitial extends AdressState {}

 class AddAdressLoading extends AdressState {}

 class AddAdressSuccess extends AdressState {}
 class GetAdressLoading extends AdressState {}
 class GetAdressSuccess extends AdressState {
   final List<AddressEntity> addresses;
   GetAdressSuccess({required this.addresses});
 }
 class AdressLoading extends AdressState {}
 class AdressSuccess extends AdressState {}


 class AdressError extends AdressState {
   final String errMessage;

   AdressError({required this.errMessage});
 }

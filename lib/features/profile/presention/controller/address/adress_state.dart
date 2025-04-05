


 import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

 class AdressInitial extends AddressState {}


 class AddressLoading extends AddressState {}
 class AddressSuccess extends AddressState {
   final List<AddressEntity> addresses;
   AddressSuccess({required this.addresses});
 }




 class AddressError extends AddressState {
   final String errMessage;

   AddressError({required this.errMessage});
 }

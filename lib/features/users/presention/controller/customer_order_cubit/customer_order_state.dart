import 'package:equatable/equatable.dart';
import 'package:shop_sphere/features/profile/domain/entity/address_entity.dart';

sealed class CustomerOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CustomerOrderInitial extends CustomerOrderState {}

final class CustomerAddressesLoading extends CustomerOrderState {}

final class CustomerAddressesSuccess extends CustomerOrderState {
  CustomerAddressesSuccess({required this.addresses});

  final List<AddressEntity> addresses;

  @override
  List<Object?> get props => [addresses];
}

final class CustomerAddressesFailure extends CustomerOrderState {
  CustomerAddressesFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

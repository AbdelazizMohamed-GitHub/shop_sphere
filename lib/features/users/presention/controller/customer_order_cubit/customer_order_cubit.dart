import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/domain/repo/address_repo.dart';
import 'package:shop_sphere/features/users/presention/controller/customer_order_cubit/customer_order_state.dart';

class CustomerOrderCubit extends Cubit<CustomerOrderState> {
  CustomerOrderCubit({required this.addressRepo})
      : super(CustomerOrderInitial());

  final AddressRepo addressRepo;

  Future<void> getCustomerAddresses({required String userId}) async {
    emit(CustomerAddressesLoading());
    final result = await addressRepo.getCustomerAddresses(userId: userId);
    result.fold(
      (failure) => emit(CustomerAddressesFailure(message: failure.message)),
      (addresses) => emit(CustomerAddressesSuccess(addresses: addresses)),
    );
  }
}

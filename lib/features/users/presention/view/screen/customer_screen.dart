import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/theme/app_color.dart';
import 'package:shop_sphere/core/theme/app_styles.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/auth/domain/entity/user_entity.dart';
import 'package:shop_sphere/features/profile/data/repo_impl/address_repo_impl.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/users/presention/controller/customer_order_cubit/customer_order_cubit.dart';
import 'package:shop_sphere/features/users/presention/controller/customer_order_cubit/customer_order_state.dart';
import 'package:shop_sphere/features/users/presention/view/widget/custom-customer-details-header.dart';
import 'package:shop_sphere/features/users/presention/view/widget/customaddrescard.dart';
import 'package:shop_sphere/features/users/presention/view/widget/customordercard.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key, required this.customer});

  final UserEntity customer;

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  late final CustomerOrderCubit _customerOrderCubit;

  @override
  void initState() {
    super.initState();
    _customerOrderCubit =
        CustomerOrderCubit(addressRepo: getIt<AddressRepoImpl>())
          ..getCustomerAddresses(userId: widget.customer.uid);
    context.read<OrderCubit>().getCustomerOrder(uId: widget.customer.uid);
  }

  @override
  void dispose() {
    _customerOrderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _customerOrderCubit,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: const Text('Customer Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCustomerDetailsCard(customer: widget.customer),
              const SizedBox(height: 20),
              const Text('Saved addresses', style: AppStyles.text22SemiBold),
              const SizedBox(height: 8),
              BlocBuilder<CustomerOrderCubit, CustomerOrderState>(
                builder: (context, state) {
                  if (state is CustomerAddressesLoading ||
                      state is CustomerOrderInitial) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is CustomerAddressesFailure) {
                    return CustomErrorWidget(
                      errorMessage: state.message.toString(),
                      onpressed: () {
                        _customerOrderCubit.getCustomerAddresses(
                            userId: widget.customer.uid);
                      },
                    );
                  }
                  if (state is CustomerAddressesSuccess) {
                    return state.addresses.isEmpty
                        ? const Text('No saved addresses.')
                        : Column(
                            children: state.addresses
                                .map(
                                    (address) => CustomAddressCard(address: address))
                                .toList(),
                          );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              const Text('Orders', style: AppStyles.text22SemiBold),
              const SizedBox(height: 8),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderSuccess) {
                    return state.orders.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('No orders found.'),
                          )
                        : Column(
                            children: state.orders
                                .map((order) => CustomOrderCard(order: order))
                                .toList(),
                          );
                  }
                  if (state is GetOrderLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is OrderError) {
                    return CustomErrorWidget(
                      errorMessage: state.error.toString(),
                      onpressed: () {
                        context
                            .read<OrderCubit>()
                            .getCustomerOrder(uId: widget.customer.uid);
                      },
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Orders are not available.'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


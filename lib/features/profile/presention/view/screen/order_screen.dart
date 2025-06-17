import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shop_sphere/core/loading/order_screen_loading.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/utils/app_theme.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_error_widget.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_cubit.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_screen_body.dart';
import 'package:shop_sphere/features/profile/presention/view/widget/custom_order_stuts_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).getUserOrders(status: 'All');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppTheme.isLightTheme(context)
            ? const CustomBackButton()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                )),
        title: const Text('My Order'),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: Column(
          children: [
            const SizedBox(height: 40, child: CustomOrderStutsList()),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is GetOrderLoading) {
                  return const OrderScreenLoading();
                } else if (state is GetOrderError) {
                  return CustomErrorWidget(
                    errorMessage: state.error,
                    onpressed: () {
                      context.read<OrderCubit>()
                          .getUserOrders(status: orderStauts[context.read<OrderCubit>().currentStatus]);
                    },
                  );
                } else if (state is OrderSuccess) {
                  if (state.orders.isEmpty) {
                    return const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(child: Text('No Orders')),
                        ],
                      ),
                    );
                  }
                  return CustomOrderScreenBody(
                    orders: state.orders,
                  );
                }
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text('No Data')),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await context
                                .read<OrderCubit>()
                                .getUserOrders(status: 'All');
                          },
                          child: const Text('Retry'))
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

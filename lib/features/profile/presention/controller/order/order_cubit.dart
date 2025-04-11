// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/screens_list.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';

import 'package:shop_sphere/features/profile/domain/repo/order_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderRepo}) : super(OrderInitial());
  final OrderRepo orderRepo;
  int currentStatus = 0;
  PageController pageController = PageController(initialPage: 0);
  void changeOrderStatus(int index) {
    currentStatus = index;
    getOrders(status: orderStauts[index]);
  }

  Future<void> createOrder({required OrderModel order}) async {
    emit(OrderLoading());
    final result = await orderRepo.craeteOrders(orderModel: order);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (r) => emit(AddOrderSuccess()),
    );
  }

  Future<void> getOrders({required String status}) async {
    emit(OrderLoading());
    final result = await orderRepo.getOrders(status: status);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (orders) => emit(OrderSuccess(orders: orders)),
    );
  }

  Future<void> deletOrder({required String orderId}) async {
    emit(OrderLoading());
    final result = await orderRepo.deletOrder(orderId: orderId);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (r) {
      
        getOrders(status: orderStauts[currentStatus]);
      },
    );
  }
}

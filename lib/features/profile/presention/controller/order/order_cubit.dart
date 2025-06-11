// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';

import 'package:shop_sphere/features/profile/domain/repo/order_repo.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderRepo}) : super(OrderInitial());
  final OrderRepo orderRepo;
  int currentStatus = 0;
  int currentTrackingNumber = 0;
  int currentOrderLength = 0;
  PageController pageController = PageController(initialPage: 0);
  void changeOrderStatus(int index) {
    currentStatus = index;
    getUserOrders(status: orderStauts[index]);
  }

  Future<void> createOrder({required OrderModel order}) async {
    emit(GetOrderLoading());
    final result = await orderRepo.craeteOrders(orderModel: order);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (r) => emit(AddOrderSuccess()),
    );
  }

  Future<void> getUserOrders({required String status}) async {
    emit(GetOrderLoading());
    final result = await orderRepo.getUserOrders(status: status);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (orders) => emit(OrderSuccess(orders: orders)),
    );
  }

  Future<void> deletOrder({required String orderId}) async {
    emit(DeletOrderLoading());
    final result = await orderRepo.deletOrder(orderId: orderId);
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (r) {
        getUserOrders(status: orderStauts[currentStatus]);
      },
    );
  }

  Future<void> changeOrdeStatus(
      {required String status, required String orderId}) async {
    emit(UpdateOrderLoading());
    final result =
        await orderRepo.changeOrdeStatus(status: status, orderId: orderId);
    result.fold((l) => emit(OrderError(error: l.message)), (r) {
      getUserOrders(status: status);
    });
  }

  Future<void> getAllOrders() async {
    emit(GetOrderLoading());
    final result = await orderRepo.getAllOrders();
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (orders) => emit(OrderSuccess(orders: orders)),
    );
  }


  Future<void> getTrackinNumber() async {
    emit(GetOrderLoading());
    final result = await orderRepo.getTrackinNumber();
    result.fold(
      (l) {
        emit(OrderError(error: l.message));
      },
      (r) {
        emit(GetTrackingNumber(trackingNumber: r));
        currentTrackingNumber = r;
       
      
      },
    );
  }
  Future<void> getOrderLength() async {
    emit(GetOrderLoading());
    final result = await orderRepo.getOrderLength();
    result.fold(
      (l) => emit(OrderError(error: l.message)),
      (length)  {
        emit(GetOrderLength(orderLength: length));
        currentOrderLength = length;
      },
    );
  }
}

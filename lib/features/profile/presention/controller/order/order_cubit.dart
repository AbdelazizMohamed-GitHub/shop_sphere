import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/presention/controller/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  int currentStatus = 0;
  PageController pageController = PageController(initialPage: 0);
  void changeOrderStatus(int index) {
    currentStatus = index;
    emit(OrderChangeStatus());
  }
}

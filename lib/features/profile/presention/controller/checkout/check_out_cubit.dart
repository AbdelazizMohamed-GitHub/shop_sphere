import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/profile/presention/controller/checkout/check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());
  int currentPaymenMethodIndex = 0;
  void chnageCurrentPaymenMethodIndex(int index) {
    currentPaymenMethodIndex = index;
    emit(CheckOutChangePaymentIndex());
  }
}

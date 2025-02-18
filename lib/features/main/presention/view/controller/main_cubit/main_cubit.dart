

import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
 int intialIndex = 0;
  void changeScreenIndex(int index) {
    intialIndex = index;
    emit(MainChangeScreenIndex());  
    
  }
}

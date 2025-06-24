import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());
  Future<void> signOut() async {
    try {
      emit(SignOutLoading());
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      emit(SignOutSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignOutError(message: e.toString()));
    } catch (e) {
      emit(SignOutError(message: e.toString()));
    }
  }
}

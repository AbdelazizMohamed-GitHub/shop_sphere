// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';

import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/auth/presention/view/screen/login_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  Future<void> _checkEmailVerification() async {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo:  AuthRepoImpl(firestoreService: FirestoreService(firestore: FirebaseFirestore.instance))),
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: const Text("Verify"),
            leading:const CustomBackButton(),
            leadingWidth: 100,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Image.asset(
                    AppImages.verifiy,
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    "Verify your email",
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "A verification link has been sent to your",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        Warning.showWarning(context, message: state.errMessage);
                      }
                      if (state is AuthVerifiy) {
                        Warning.showWarning(context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return _isEmailVerified
                            ? CustomButton(
                                text: "login",
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                              )
                            : CustomButton(
                                text: "Resend",
                                onPressed: () async {
                                  await _auth.currentUser?.reload();
                                  setState(() {
                                    _isEmailVerified =
                                        _auth.currentUser?.emailVerified ??
                                            false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  context.read<AuthCubit>().verifiyEmaill();
                                },
                              );
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

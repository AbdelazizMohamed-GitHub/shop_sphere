import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) { final horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            Image.asset(
              AppImages.forgetPasswordImage,
              width: 220,
              height: 220,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Forgot your password? Lets get you back on track! 🌟',
              style: AppStyles.text18Regular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextForm(
              textController: emailController,
              pIcon: Icons.email,
              text: 'Email',
              kType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocProvider(
              create: (context) => AuthCubit(authRepo:getIt<AuthRepoImpl>()),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    Warning.showWarning(context, message: state.errMessage,isError:  true);
                  }
                  else if (state is ResetPassword) {
                    Warning.showWarning(context, message: 'Password reset link sent to your email',isError: false);
                    
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onPressed: () {
                            if (emailController.text.isNotEmpty) {
                              
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<AuthCubit>(context)
                                  .resetPassword(email: emailController.text);
                            }
                          },
                          text: 'Reset Password');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

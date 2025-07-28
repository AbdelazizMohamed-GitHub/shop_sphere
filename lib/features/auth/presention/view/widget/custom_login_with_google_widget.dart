
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_cubit.dart';
import 'package:shop_sphere/features/auth/presention/cotroller/auth_cubit/auth_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/main/presention/view/screen/main_screen.dart';

class CustomLogInWithGoogle extends StatelessWidget {
  const CustomLogInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Warning.showWarning(context,
              message: state.errMessage, isError: true);
        }
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    state.uid == 'Staff' ? const ProductScreen() : const MainScreen(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is GoogleAuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // ✅ لو Web: نعرض رسالة مع زر GSI الرسمي
       
        // ✅ باقي المنصات: نعرض زرنا العادي
        return InkWell(
          onTap: ()async {
           await BlocProvider.of<AuthCubit>(context).loginWithGoogle();
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.google),
                const SizedBox(width: 10),
                const Text(
                  'Sign in with Google',
                  style: AppStyles.text18Regular,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

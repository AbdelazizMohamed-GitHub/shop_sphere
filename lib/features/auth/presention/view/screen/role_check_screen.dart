
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/service/user_service.dart';
import 'package:shop_sphere/core/utils/app_route.dart';

class RoleCheckScreen extends StatefulWidget {
  const RoleCheckScreen({super.key});

  @override
  State<RoleCheckScreen> createState() => _RoleCheckScreenState();
}

class _RoleCheckScreenState extends State<RoleCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  Future<void> _checkRole() async {
    try {
      final user = await getIt<UserService>().getUserData();
      if (!mounted) return;
      context.goNamed(user.isStaff ? AppRoute.dashboard : AppRoute.main);
    } catch (_) {
      if (!mounted) return;
      context.goNamed(AppRoute.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/add_product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/ddashboard_details_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_details.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/orders_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/search_screen.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/profile/data/model/orer_model.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/Products',
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: '/Orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/Orders/OrderDetails',
      builder: (context, state) {
        final order = state.extra as OrderModel;
        return OrdersDetailsScreen(order: order);
      },
    ),
    GoRoute(
      path: '/AddProduct',
      builder: (context, state) => const AddProductScreen(
        isUpdate: false,
      ),
    ),
    GoRoute(
        path: '/details/:name',
        builder: (context, state) {
           final nameFromUrl = state.pathParameters['name'];
          final product = state.extra as ProductModel;
          return DashboardProductDetailsScreen(product: product);
        }),
    GoRoute(
      path: '/Search',
      builder: (context, state) => const SearchScreen(),
    ),
    // GoRoute(
    //   path: '/orders',
    //   builder: (context, state) => const OrdersScreen(),
    // ),
    // GoRoute(
    //   path: '/orders',
    //   builder: (context, state) => const OrdersScreen(),
    // ),
  ],
);

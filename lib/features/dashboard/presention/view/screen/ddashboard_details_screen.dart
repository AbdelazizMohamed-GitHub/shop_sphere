import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_circle_button.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class DashboardProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const DashboardProductDetailsScreen({super.key, required this.product});

  @override
  State<DashboardProductDetailsScreen> createState() =>
      _DashboardProductDetailsScreenState();
}

class _DashboardProductDetailsScreenState
    extends State<DashboardProductDetailsScreen> {
  bool _didSyncUrl = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didSyncUrl) return;

    final currentId = GoRouterState.of(context).pathParameters['productId'];

    // If the user refreshed and the URL doesn't contain productId, go_router
    // can't re-fetch the product. Rewrite the URL to include the ID.
    if (currentId == null ||
        currentId.isEmpty ||
        currentId != widget.product.pId) {
      _didSyncUrl = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/product-details/${widget.product.pId}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final discountedPrice = widget.product.price -
        (widget.product.price * widget.product.discount / 100);
    double horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomCircleButton(
            icon: const Icon(Icons.edit, size: 25),
            funcation: () {
              context.goNamed(
                AppRoute.addProduct,
                extra: {
                  'isUpdate': true,
                  'product': widget.product,
                },
              );
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text(
          'Details',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: 16, horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: widget.product.pId,
                child: CachedNetworkImage(
                  imageUrl: widget.product.imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Name + Category
            Text(widget.product.name,
                style: Theme.of(context).textTheme.headlineSmall),
            Text("Category: ${widget.product.category}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            // Price
            Row(
              children: [
                if (widget.product.discount > 0)
                  Text(
                    "${widget.product.price.toStringAsFixed(2)} EGP",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  "${discountedPrice.toStringAsFixed(2)} EGP",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (widget.product.discount > 0)
                  Text(
                    " (${widget.product.discount}%)",
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(widget.product.description,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Stock & Staff
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Stock: ${widget.product.stock}",
                    style: AppStyles.text18Regular),
                Text("Staff: ${widget.product.staffName}",
                    style: AppStyles.text18Regular),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        child: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {
            if (state is DashboardSuccess) {
              context.goNamed(AppRoute.dashboard);
            } else if (state is DashboardFailer) {
              Warning.showWarning(context,
                  message: state.errMessage, isError: true);
            }
          },
          builder: (context, state) {
            return CustomButton(
                onPressed: () async {
                  await context.read<DashboardCubit>().deleteProduct(
                      dId: widget.product.pId,
                      imageUrl: widget.product.imageUrl);
                },
                text: state is DashboardLoading ? 'Deleting...' : 'Delete');
          },
        ),
      ),
    );
  }
}

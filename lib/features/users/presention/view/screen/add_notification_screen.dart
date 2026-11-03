import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:shop_sphere/features/users/data/repo_impl/notification_repo_impl.dart';
import 'package:shop_sphere/features/users/presention/controller/add_notification_cubit/add_notification_cubit.dart';

import '../../../../../core/loading/custom_image_loading.dart'
    show CustomImageLoading;

// Add your actual ProductEntity import here.

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({
    super.key,
    required this.fCM,
    required this.userName,
  });

  final String fCM;
  final String userName;

  @override
  State<AddNotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<AddNotificationScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  late Future<List<ProductEntity>> _productsFuture;
  ProductEntity? selectedProduct;

  @override
  void initState() {
    super.initState();
    _productsFuture = getIt<FirestoreService>().gettProducts(category: 'All');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        ResponsiveLayout.getHorizontalLargePadding(context);

    return BlocProvider(
      create: (_) => AddNotificationCubit(
        notificationRepo: getIt<NotificationRepoImpl>(),
      ),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            title: const Text('Product Offer'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send offer to ${widget.userName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                CustomTextForm(
                  text: 'Notification Title *',
                  textController: _titleController,
                  kType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                CustomTextForm(
                  text: 'Notification Body *',
                  textController: _bodyController,
                  lines: 4,
                  kType: TextInputType.multiline,
                ),
                const SizedBox(height: 24),
                Text(
                  'Select Product *',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                FutureBuilder<List<ProductEntity>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Could not load products: ${snapshot.error}'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _productsFuture = getIt<FirestoreService>()
                                    .gettProducts(category: 'All');
                              });
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    }

                    final products = snapshot.data ?? [];
                    if (products.isEmpty) {
                      return const Text('No products available.');
                    }

                    return DropdownButtonFormField<ProductEntity>(
                      initialValue: selectedProduct,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        hintText: 'Choose product',
                        border: OutlineInputBorder(),
                      ),
                      items: products.map((product) {
                        return DropdownMenuItem<ProductEntity>(
                          value: product,
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (product) {
                        setState(() {
                          selectedProduct = product;
                        });
                      },
                    );
                  },
                ),
                if (selectedProduct != null) ...[
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: selectedProduct!.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CustomImageLoading(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProduct!.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Price: ${selectedProduct!.price}',
                                ),
                                Text(
                                  'Discount: ${selectedProduct!.discount}%',
                                ),
                                Text(
                                  'Product ID: ${selectedProduct!.pId}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                BlocConsumer<AddNotificationCubit, AddNotificationState>(
                  listener: (context, state) {
                    if (state is AddNotificationSuccess) {
                      Warning.showWarning(
                        context,
                        message: 'Notification sent successfully',
                        isError: false,
                      );
                      Navigator.pop(context);
                    } else if (state is AddNotificationFailure) {
                      Warning.showWarning(
                        context,
                        message: state.errMessage,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddNotificationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return CustomButton(
                        text: 'Send To ${widget.userName}',
                        onPressed: () => context
                            .read<AddNotificationCubit>()
                            .addNotification(
                              title: _titleController.text,
                              body: _bodyController.text,
                              productId: selectedProduct?.pId ?? '',
                              token: widget.fCM,
                              imageUrl: selectedProduct?.imageUrl ?? '',
                            ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

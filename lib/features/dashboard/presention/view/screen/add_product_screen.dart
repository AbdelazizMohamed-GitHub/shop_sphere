// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/utils/app_data.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/core/widget/custom_dropdown_menu.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/product_screen.dart';
import 'package:shop_sphere/features/explor/data/model/product_model.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';
import 'package:uuid/uuid.dart';

import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_cubit.dart';
import 'package:shop_sphere/features/dashboard/presention/view/controller/product_cubit/dashboard_state.dart';
import 'package:shop_sphere/features/dashboard/presention/view/widget/custom_add_image.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    super.key,
    required this.isUpdate,
    this.productEntity,
  });
  final ProductEntity? productEntity;
  final bool isUpdate;
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? selectedCategory;
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int discount = 0;
  File? imageFile;
  @override
  void initState() {
    if (widget.isUpdate) {
      nameController.text = widget.productEntity!.name;
      quantityController.text = widget.productEntity!.stock.toString();
      priceController.text = widget.productEntity!.price.toString();
      descriptionController.text = widget.productEntity!.description;
      selectedCategory = widget.productEntity!.category;
      discount = widget.productEntity!.discount;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String dId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(widget.isUpdate ? "Update Product" : "Add Product"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                CustomTextForm(
                  textController: nameController,
                  pIcon: Icons.title,
                  text: "Product Name",
                  kType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                CustomTextForm(
                  textController: quantityController,
                  pIcon: Icons.numbers,
                  text: "Product Quantity",
                  kType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextForm(
                        textController: priceController,
                        pIcon: Icons.money_off_rounded,
                        text: " Price",
                        kType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: CustomDropdown(
                        
                          isUpdate: widget.isUpdate,
                        categories: const [
                          '0',
                          '5',
                          '10',
                          '20',
                          '30',
                          '40',
                          '50',
                          '60',
                          '70',
                          '80',
                          '90',
                          '100'
                        ],
                        onCategorySelected: (value) {
                          discount = int.parse(value);
                        },
                        text: "Discount",
                       
                        productCategory: discount.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  productCategory: selectedCategory,
                  isUpdate: widget.isUpdate,
                  categories: appCategory.map((e) => e.toString()).toList(),
                  onCategorySelected: (value) {
                    selectedCategory = value;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextForm(
                  textController: descriptionController,
                  pIcon: null,
                  text: "Product Description",
                  kType: TextInputType.text,
                  lines: 4,
                ),
                const SizedBox(height: 15),
                CustomAddImage(
                  imageUrl:
                      widget.isUpdate ? widget.productEntity!.imageUrl : "",
                  onTap: (File file) {
                    imageFile = file;
                  },
                ),
                const SizedBox(height: 20),
                BlocConsumer<DashboardCubit, DashboardState>(
                  listener: (context, state) {
                    if (state is DashboardFailer) {
                      Warning.showWarning(context, message: state.errMessage);
                    }
                    if (state is DashboardSuccess) {
                      Warning.showWarning(context,
                          message: widget.isUpdate
                              ? "Product Updated Successfully"
                              : "Product Added Successfully");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is DashboardLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  selectedCategory != null) {
                                if (imageFile != null || widget.isUpdate) {
                                  final user = await FirestoreService(
                                    firestore: FirebaseFirestore.instance,
                                  ).getUserData();

                                  final baseProduct = widget.isUpdate
                                      ? (widget.productEntity! as ProductModel)
                                          .copyWith(
                                          name: nameController.text,
                                          price: double.parse(
                                              priceController.text),
                                          stock: int.parse(
                                              quantityController.text),
                                          category: selectedCategory!,
                                          description:
                                              descriptionController.text,
                                        )
                                      : ProductModel(
                                          discount: discount,
                                          staffName: user.name,
                                          createdAt: DateTime.now(),
                                          name: nameController.text,
                                          price: double.parse(
                                              priceController.text),
                                          stock: int.parse(
                                              quantityController.text),
                                          category: selectedCategory!,
                                          description:
                                              descriptionController.text,
                                          pId: dId,
                                          sId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          imageUrl: '',
                                          isFeatured: false,
                                        );

                                  if (widget.isUpdate) {
                                    await context
                                        .read<DashboardCubit>()
                                        .updateProduct(
                                          dId: widget.productEntity!.pId,
                                          data: baseProduct,
                                        );
                                  } else {
                                    await context
                                        .read<DashboardCubit>()
                                        .addProduct(
                                          product: baseProduct,
                                          imageFile: imageFile!,
                                        );
                                  }
                                } else {
                                  Warning.showWarning(context,
                                      message: "Please Add Image");
                                }
                              }
                            },
                            text: widget.isUpdate
                                ? "Update Product"
                                : "Add Product",
                          );
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

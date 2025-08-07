import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_sphere/core/service/firestore_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_route.dart';
import 'package:shop_sphere/core/utils/responsive_layout.dart';
import 'package:shop_sphere/core/widget/custom_back_button.dart';
import 'package:shop_sphere/features/dashboard/presention/view/screen/dashboard_search_result.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double horizontalPadding=ResponsiveLayout.getHorizontalLargePadding(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Search"),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:horizontalPadding, vertical: 16),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              hintText: "Search for products...",
              onChanged: (query) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController controller,
          ) async {
            final query = controller.text.toLowerCase();
            final products = await FirestoreService(firestore: getIt<FirebaseFirestore>()).gettProducts(category: "All");
            final results = products
                .where((product) => product.name.toLowerCase().contains(query)|| product.description.toLowerCase().contains(query)|| product.category.toLowerCase().contains(query))
                .toList();

            return results.map((product) {
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller.closeView(product.name);
               context.go(
                    AppRoute.dashboardSearchResult,
                    extra: DashboardSearchResult(products: results),
                  );
                },
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

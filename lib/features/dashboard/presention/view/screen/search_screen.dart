import 'package:flutter/material.dart';
import 'package:shop_sphere_dashboard/core/service/firestore_service.dart';
import 'package:shop_sphere_dashboard/core/widget/custom_back_button.dart';
import 'package:shop_sphere_dashboard/features/presention/view/screen/details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              hintText: "Search for products...",
              onChanged: (query) {
                controller.openView();
              },
              leading: Icon(Icons.search),
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController controller,
          ) async {
            final query = controller.text.toLowerCase();
            final products = await FirestoreService().gettProducts();
            final results = products
                .where((product) => product.name.toLowerCase().contains(query))
                .toList();

            return results.map((product) {
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller.closeView(product.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(product: product),
                    ),
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

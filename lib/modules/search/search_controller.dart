// import 'package:get/get.dart';
// import '../../data/models/product_model.dart';
// import '../../data/services/dummy_data.dart';

// class LuxeSearchController extends GetxController {
//   final query = ''.obs;
//   final results = <ProductModel>[].obs;
//   final isSearching = false.obs;
//   final recentSearches = <String>['Blazer', 'Watch', 'Sneakers'].obs;

//   List<ProductModel> get allProducts => DummyData.products;

//   void onSearch(String value) {
//     query.value = value;
//     if (value.trim().isEmpty) {
//       results.clear();
//       return;
//     }
//     isSearching.value = true;
//     final q = value.toLowerCase();
//     results.assignAll(
//       allProducts.where((p) =>
//           p.name.toLowerCase().contains(q) ||
//           p.categoryId.toLowerCase().contains(q) ||
//           p.description.toLowerCase().contains(q)),
//     );
//     isSearching.value = false;
//   }

//   void searchRecent(String term) => onSearch(term);

//   void clearSearch() {
//     query.value = '';
//     results.clear();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/services/dummy_data.dart';

class LuxeSearchController extends GetxController {
  final query = ''.obs;
  final results = <ProductModel>[].obs;
  final isSearching = false.obs;
  final recentSearches = <String>['Blazer', 'Watch', 'Sneakers'].obs;

  // Add this so clearSearch also clears the TextField visually
  final textController = TextEditingController();

  List<ProductModel> get allProducts => DummyData.products;

  void onSearch(String value) {
    query.value = value;
    if (value.trim().isEmpty) {
      results.clear();
      return;
    }
    isSearching.value = true;
    final q = value.toLowerCase();
    results.assignAll(
      allProducts.where((p) =>
          p.name.toLowerCase().contains(q) ||
          p.categoryId.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q)),
    );
    isSearching.value = false;

    // Save to recent searches (avoid duplicates)
    if (!recentSearches.contains(value)) {
      recentSearches.insert(0, value);
      if (recentSearches.length > 6) recentSearches.removeLast();
    }
  }

  void searchRecent(String term) {
    textController.text = term; // syncs the TextField text
    onSearch(term);
  }

  void clearSearch() {
    query.value = '';
    results.clear();
    textController.clear(); // clears the TextField visually
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
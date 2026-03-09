import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class WishlistController extends GetxController {
  final wishlistItems = <ProductModel>[].obs;

  bool isWishlisted(String productId) =>
      wishlistItems.any((p) => p.id == productId);

  void toggleWishlist(ProductModel product) {
    if (isWishlisted(product.id)) {
      wishlistItems.removeWhere((p) => p.id == product.id);
    } else {
      wishlistItems.add(product);
      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF12121A),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        titleText: const Text('Added to Wishlist',
            style: TextStyle(color: Color(0xFFF0F0FF), fontWeight: FontWeight.w600)),
        messageText: Text(product.name,
            style: const TextStyle(color: Color(0xFF9090B0), fontSize: 13)),
        icon: const Icon(Icons.favorite, color: Color(0xFFEF4444)),
      );
    }
  }

  void removeFromWishlist(String productId) =>
      wishlistItems.removeWhere((p) => p.id == productId);
}

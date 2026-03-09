import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import 'package:flutter/material.dart';


class CartController extends GetxController {
  final cartItems = <CartItemModel>[].obs;

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => subtotal > 200 ? 0 : 14.99;

  double get total => subtotal + deliveryFee;

  bool isInCart(String productId) => cartItems.any((e) => e.product.id == productId);

  void addToCart(ProductModel product, String size, {String color = '#1A1A1A'}) {
    final index = cartItems.indexWhere(
        (e) => e.product.id == product.id && e.selectedSize == size);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItemModel(
        product: product,
        quantity: 1,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF12121A),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      titleText: const Text('Added to Cart',
          style: TextStyle(color: Color(0xFFF0F0FF), fontWeight: FontWeight.w600)),
      messageText: Text(product.name,
          style: const TextStyle(color: Color(0xFF9090B0), fontSize: 13)),
      icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF7C3AED)),
    );
  }

  void removeFromCart(int index) => cartItems.removeAt(index);

  void increment(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrement(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(index);
    }
  }

  void clearCart() => cartItems.clear();
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import '../cart/cart_controller.dart';

class CheckoutController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();

  final selectedPayment = 0.obs;
  final isLoading = false.obs;
  final currentStep = 0.obs;

  final paymentMethods = ['Credit Card', 'PayPal', 'Apple Pay', 'Google Pay'];

  @override
  void onInit() {
    super.onInit();
    // Pre-fill with dummy data
    nameController.text = 'Alex Morgan';
    emailController.text = 'alex.morgan@email.com';
    phoneController.text = '+1 (555) 012-3456';
    addressController.text = '123 Luxury Avenue, Suite 4B';
    cityController.text = 'New York';
    zipController.text = '10001';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.onClose();
  }

  void nextStep() {
    if (currentStep.value < 2) currentStep.value++;
  }

  void prevStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  Future<void> placeOrder() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.find<CartController>().clearCart();
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.orderSuccess);
  }
}

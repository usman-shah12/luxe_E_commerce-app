import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/constants.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
Future<void> login() async {
  // TODO: Replace with real auth + validation
  Get.offAllNamed(AppRoutes.home);
}

// ── Temporary signup — no validation, goes straight to Home ──
Future<void> signup() async {
  // TODO: Replace with real auth + validation
  Get.offAllNamed(AppRoutes.home);
}
  // Future<void> login() async {
  //   if (!loginFormKey.currentState!.validate()) return;
  //   isLoading.value = true;
  //   await Future.delayed(const Duration(milliseconds: 1500));
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(AppConstants.keyLoggedIn, true);
  //   isLoading.value = false;
  //   Get.offAllNamed(AppRoutes.home);
  // }

  // Future<void> signup() async {
  //   if (!signupFormKey.currentState!.validate()) return;
  //   isLoading.value = true;
  //   await Future.delayed(const Duration(milliseconds: 1500));
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(AppConstants.keyLoggedIn, true);
  //   isLoading.value = false;
  //   Get.offAllNamed(AppRoutes.home);
  // }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyLoggedIn, false);
    Get.offAllNamed(AppRoutes.login);
  }

  String? validateEmail(String? val) {
    if (val == null || val.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(val)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Password is required';
    if (val.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateName(String? val) {
    if (val == null || val.isEmpty) return 'Name is required';
    return null;
  }
}

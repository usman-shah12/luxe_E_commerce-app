import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  if (!loginFormKey.currentState!.validate()) return;

  try {
    isLoading.value = true;

    await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    Get.offAllNamed(AppRoutes.home);

  } on FirebaseAuthException catch (e) {
    String message = "Login failed";

    if (e.code == 'user-not-found') {
      message = "No user found with this email";
    } else if (e.code == 'wrong-password') {
      message = "Incorrect password";
    }

    Get.snackbar("Login Error", message,
        snackPosition: SnackPosition.BOTTOM);

  } finally {
    isLoading.value = false;
  }
}

Future<void> signup() async {
  if (!signupFormKey.currentState!.validate()) return;

  try {
    isLoading.value = true;

    // Create user with Firebase
    await _auth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Optional: set display name
    await _auth.currentUser?.updateDisplayName(nameController.text.trim());

    // Navigate back to login screen instead of home
    Get.back(); // goes back to LoginView

    // Optional: show a success message
    Get.snackbar(
      "Success",
      "Account created! Please login.",
      snackPosition: SnackPosition.BOTTOM,
    );

  } on FirebaseAuthException catch (e) {
    String message = "Signup failed";

    if (e.code == 'email-already-in-use') {
      message = "Email already in use";
    } else if (e.code == 'weak-password') {
      message = "Password is too weak";
    }

    Get.snackbar(
      "Signup Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );

  } finally {
    isLoading.value = false;
  }
}  

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(AppConstants.keyLoggedIn, false);
  //   Get.offAllNamed(AppRoutes.login);
  // }
  Future<void> logout() async {
  await _auth.signOut();
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

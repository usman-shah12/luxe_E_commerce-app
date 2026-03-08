import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/constants.dart';
import '../../data/services/dummy_data.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;
  final pages = DummyData.onboardingData;
  final pageController = PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) => currentPage.value = index;

  bool get isLastPage => currentPage.value == pages.length - 1;

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyOnboarded, true);
    Get.offAllNamed(AppRoutes.login);
  }

  void next() {
    if (isLastPage) {
      complete();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
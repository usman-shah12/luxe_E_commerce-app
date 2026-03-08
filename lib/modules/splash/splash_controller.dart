import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final prefs = await SharedPreferences.getInstance();
    final isOnboarded = prefs.getBool(AppConstants.keyOnboarded) ?? false;
    final isLoggedIn = prefs.getBool(AppConstants.keyLoggedIn) ?? false;

    if (!isOnboarded) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (!isLoggedIn) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }
}

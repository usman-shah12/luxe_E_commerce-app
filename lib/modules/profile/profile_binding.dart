import 'package:get/get.dart';
import 'profile_controller.dart';
import '../auth/auth_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

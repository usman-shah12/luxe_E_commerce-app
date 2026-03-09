import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../auth/auth_controller.dart';

class ProfileController extends GetxController {
  final user = UserModel.dummy.obs;

  void logout() => Get.find<AuthController>().logout();
}

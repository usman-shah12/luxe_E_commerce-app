import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final user = UserModel.dummy.obs;
  final isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _auth.signOut(); // Firebase logout
      // Navigate to login
      Get.offAllNamed('/login'); // or AppRoutes.login
    } finally {
      isLoading.value = false;
    }
  }
}
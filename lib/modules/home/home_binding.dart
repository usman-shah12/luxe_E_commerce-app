import 'package:get/get.dart';
import 'home_controller.dart';
import '../cart/cart_controller.dart';
import '../wishlist/wishlist_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<CartController>(CartController(), permanent: true);
    Get.put<WishlistController>(WishlistController(), permanent: true);
  }
}

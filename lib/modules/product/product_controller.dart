import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class ProductController extends GetxController {
  late ProductModel product;
  final selectedSize = ''.obs;
  final selectedColor = ''.obs;
  final selectedImageIndex = 0.obs;
  final quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
    if (product.sizes.isNotEmpty) selectedSize.value = product.sizes[0];
    if (product.colors.isNotEmpty) selectedColor.value = product.colors[0];
  }

  void selectSize(String size) => selectedSize.value = size;
  void selectColor(String color) => selectedColor.value = color;
  void selectImage(int index) => selectedImageIndex.value = index;

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }
}

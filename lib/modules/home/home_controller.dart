import 'package:get/get.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/services/dummy_data.dart';

class HomeController extends GetxController {
  final selectedCategoryId = 'all'.obs;
  final isLoading = true.obs;
  final currentBannerIndex = 0.obs;
  final currentNavIndex = 0.obs;

  List<CategoryModel> get categories => DummyData.categories;
  List<String> get banners => DummyData.bannerUrls;
  List<ProductModel> get allProducts => DummyData.products;

  List<ProductModel> get featuredProducts =>
      allProducts.where((p) => p.isFeatured).toList();

  List<ProductModel> get filteredProducts {
    if (selectedCategoryId.value == 'all') return allProducts;
    return allProducts
        .where((p) => p.categoryId == selectedCategoryId.value)
        .toList();
  }

  void selectCategory(String id) => selectedCategoryId.value = id;

  void onBannerChanged(int index) => currentBannerIndex.value = index;

  void changeNav(int index) => currentNavIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
  }
}

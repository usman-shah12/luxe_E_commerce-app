import 'package:get/get.dart';
import 'search_controller.dart' as sc;

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<sc.LuxeSearchController>(() => sc.LuxeSearchController());
  }
}

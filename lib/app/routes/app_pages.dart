import 'package:get/get.dart';
import '../../modules/splash/splash_binding.dart';
import '../../modules/splash/splash_view.dart';
import '../../modules/onboarding/onboarding_binding.dart';
import '../../modules/onboarding/onboarding_view.dart';
import '../../modules/auth/auth_binding.dart';
import '../../modules/auth/login_view.dart';
import '../../modules/auth/signup_view.dart';
import '../../modules/home/home_binding.dart';
import '../../modules/home/home_view.dart';
import '../../modules/product/product_binding.dart';
import '../../modules/product/product_detail_view.dart';
import '../../modules/cart/cart_binding.dart';
import '../../modules/cart/cart_view.dart';
import '../../modules/checkout/checkout_binding.dart';
import '../../modules/checkout/checkout_view.dart';
import '../../modules/order_success/order_success_view.dart';
import '../../modules/profile/profile_binding.dart';
import '../../modules/profile/profile_view.dart';
import '../../modules/search/search_binding.dart';
import '../../modules/search/search_view.dart';
import '../../modules/wishlist/wishlist_binding.dart';
import '../../modules/wishlist/wishlist_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailView(),
      binding: ProductBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessView(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}

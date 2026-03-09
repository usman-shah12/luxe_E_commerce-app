import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/responsive.dart';
import '../../data/models/category_model.dart';
import '../../widgets/product_card.dart';
import '../../widgets/loading_widget.dart';
import '../cart/cart_controller.dart';
import '../wishlist/wishlist_view.dart';
import '../profile/profile_view.dart';
import '../search/search_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.currentNavIndex.value;
      return Scaffold(
        backgroundColor: AppColors.bgDark,
        body: IndexedStack(
          index: navIndex,
          children: const [
            _HomeBody(),
            SearchView(isEmbedded: true),
            WishlistView(isEmbedded: true),
            ProfileView(isEmbedded: true),
          ],
        ),
        bottomNavigationBar: _BottomNav(),
      );
    });
  }
}

class _BottomNav extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();
    return Obx(() => Container(
          decoration: const BoxDecoration(
            color: AppColors.bgCard,
            border: Border(top: BorderSide(color: AppColors.borderColor, width: 0.5)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home', index: 0),
                  const _NavItem(icon: Icons.search_outlined, activeIcon: Icons.search_rounded, label: 'Search', index: 1),
                  // Cart FAB
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.cart),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: AppColors.gradientPrimary,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 22),
                            ),
                            if (cartCtrl.totalItems > 0)
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${cartCtrl.totalItems}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text('Cart', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  const _NavItem(icon: Icons.favorite_outline, activeIcon: Icons.favorite_rounded, label: 'Wishlist', index: 2),
                  const _NavItem(icon: Icons.person_outline, activeIcon: Icons.person_rounded, label: 'Profile', index: 3),
                ],
              ),
            ),
          ),
        ));
  }
}

class _NavItem extends GetView<HomeController> {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;

  const _NavItem({required this.icon, required this.activeIcon, required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isActive = controller.currentNavIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeNav(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primary : AppColors.textMuted,
                size: 22,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: isActive ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _HomeBody extends GetView<HomeController> {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          backgroundColor: AppColors.bgDark,
          floating: true,
          snap: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.diamond_outlined, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'LUXE',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Morning,', style: AppTextStyles.bodyMedium),
                    Text(
                      'SYED ✦',
                      style: AppTextStyles.h2,
                    ),
                  ],
                ),
              ),

              // Banner Slider
              _BannerSlider(),

              const SizedBox(height: 28),

              // Categories
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
                child: Text('Categories', style: AppTextStyles.h3),
              ),
              _CategoriesRow(),

              const SizedBox(height: 28),

              // Featured
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
                child: Row(
                  children: [
                    Text('Featured', style: AppTextStyles.h3),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('HOT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              _FeaturedProducts(context: context),

              const SizedBox(height: 28),

              // All Products
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          controller.selectedCategoryId.value == 'all'
                              ? 'All Products'
                              : controller.categories
                                  .firstWhere((c) => c.id == controller.selectedCategoryId.value)
                                  .name,
                          style: AppTextStyles.h3,
                        )),
                    Text('${controller.filteredProducts.length} items',
                        style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              _ProductsGrid(context: context),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class _BannerSlider extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width >= 600 ? 260 : 200,
            viewportFraction: 0.88,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (i, _) => controller.onBannerChanged(i),
          ),
          items: controller.banners.map((url) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(url, fit: BoxFit.cover),
                    Container(
                      decoration: const BoxDecoration(gradient: AppColors.gradientBanner),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NEW COLLECTION', style: AppTextStyles.labelSmall.copyWith(color: AppColors.gold)),
                          const SizedBox(height: 4),
                          Text('Up to 30% Off', style: AppTextStyles.h2),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Shop', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Obx(() => AnimatedSmoothIndicator(
              activeIndex: controller.currentBannerIndex.value,
              count: controller.banners.length,
              effect: const WormEffect(
                dotColor: AppColors.bgElevated,
                activeDotColor: AppColors.primary,
                dotHeight: 5,
                dotWidth: 5,
              ),
            )),
      ],
    );
  }
}

class _CategoriesRow extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = controller.categories[i];
          return Obx(() {
            final isSelected = controller.selectedCategoryId.value == cat.id;
            return GestureDetector(
              onTap: () => controller.selectCategory(cat.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.gradientPrimary : null,
                  color: isSelected ? null : AppColors.bgCard,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : AppColors.borderColor,
                    width: 0.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat.icon, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      cat.name,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class _FeaturedProducts extends GetView<HomeController> {
  final BuildContext context;
  const _FeaturedProducts({required this.context});

  @override
  Widget build(BuildContext _) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) => ShimmerBox(
              width: MediaQuery.of(context).size.width >= 600 ? 220 : 170,
              height: 260,
              radius: 16,
            ),
          ),
        );
      }
      final products = controller.featuredProducts;
      return SizedBox(
        height: 280,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: products.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (_, i) => SizedBox(
            width: MediaQuery.of(context).size.width >= 600 ? 220 : 175,
            child: ProductCard(product: products[i]),
          ),
        ),
      );
    });
  }
}

class _ProductsGrid extends GetView<HomeController> {
  final BuildContext context;
  const _ProductsGrid({required this.context});

  @override
  Widget build(BuildContext _) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: LoadingWidget(),
        );
      }
      final products = controller.filteredProducts;
      final crossAxis = Responsive.gridCrossAxisCount(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxis,
            childAspectRatio: 0.62,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemCount: products.length,
          itemBuilder: (_, i) => ProductCard(product: products[i]),
        ),
      );
    });
  }
}

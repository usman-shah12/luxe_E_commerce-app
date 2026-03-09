import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../cart/cart_controller.dart';
import '../wishlist/wishlist_controller.dart';
import 'product_controller.dart';

class ProductDetailView extends GetView<ProductController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();
    final wishlistCtrl = Get.find<WishlistController>();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: Get.back,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.bgDark.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 18),
          ),
        ),
        actions: [
          Obx(() => GestureDetector(
                onTap: () => wishlistCtrl.toggleWishlist(controller.product),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.bgDark.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    wishlistCtrl.isWishlisted(controller.product.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: wishlistCtrl.isWishlisted(controller.product.id)
                        ? AppColors.error
                        : AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              )),
          const SizedBox(width: 4),
        ],
      ),
      body: isTablet
          ? _TabletLayout(cartCtrl: cartCtrl)
          : _MobileLayout(cartCtrl: cartCtrl),
    );
  }
}

class _MobileLayout extends GetView<ProductController> {
  final CartController cartCtrl;
  const _MobileLayout({required this.cartCtrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image section
        Obx(() => SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: controller.product.images.length,
                    onPageChanged: controller.selectImage,
                    itemBuilder: (_, i) => Image.network(
                      controller.product.images[i],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  // Image thumbnails
                  if (controller.product.images.length > 1)
                    Positioned(
                      right: 16,
                      top: 80,
                      child: Column(
                        children: List.generate(
                          controller.product.images.length,
                          (i) => GestureDetector(
                            onTap: () => controller.selectImage(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(bottom: 8),
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.selectedImageIndex.value == i
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  controller.product.images[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )),

        // Details
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.bgDark,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.all(24),
              child: _ProductInfo(cartCtrl: cartCtrl),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabletLayout extends GetView<ProductController> {
  final CartController cartCtrl;
  const _TabletLayout({required this.cartCtrl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Obx(() => Image.network(
                  controller.product.images[controller.selectedImageIndex.value],
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: _ProductInfo(cartCtrl: cartCtrl),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductInfo extends GetView<ProductController> {
  final CartController cartCtrl;
  const _ProductInfo({required this.cartCtrl});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            p.categoryId.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 12),
        Text(p.name, style: AppTextStyles.h1),
        const SizedBox(height: 12),
        // Rating
        Row(
          children: [
            RatingBarIndicator(
              rating: p.rating,
              itemBuilder: (_, __) => const Icon(Icons.star_rounded, color: AppColors.gold),
              itemCount: 5,
              itemSize: 16,
            ),
            const SizedBox(width: 8),
            Text('${p.rating}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
            const SizedBox(width: 4),
            Text('(${p.reviewCount} reviews)', style: AppTextStyles.bodySmall),
          ],
        ),
        const SizedBox(height: 16),
        // Price
        Row(
          children: [
            Text('\$${p.price.toStringAsFixed(2)}', style: AppTextStyles.priceTag),
            if (p.hasDiscount) ...[
              const SizedBox(width: 12),
              Text(
                '\$${p.originalPrice!.toStringAsFixed(0)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '-${p.discountPercent.toInt()}%',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.error),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
        // Description
        Text('Description', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        Text(p.description, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 24),

        // Sizes
        if (p.sizes.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Size', style: AppTextStyles.h4),
              Text('Size Guide', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => Wrap(
                spacing: 10,
                children: p.sizes.map((s) {
                  final isSelected = controller.selectedSize.value == s;
                  return GestureDetector(
                    onTap: () => controller.selectSize(s),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.gradientPrimary : null,
                        color: isSelected ? null : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : AppColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          s,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
          const SizedBox(height: 24),
        ],

        // Colors
        if (p.colors.isNotEmpty) ...[
          Text('Color', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          Obx(() => Wrap(
                spacing: 10,
                children: p.colors.map((hex) {
                  final color = Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));
                  final isSelected = controller.selectedColor.value == hex;
                  return GestureDetector(
                    onTap: () => controller.selectColor(hex),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.borderColor,
                          width: isSelected ? 2.5 : 1,
                        ),
                        boxShadow: isSelected
                            ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8)]
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              )),
          const SizedBox(height: 28),
        ],

        // Add to cart
        Row(
          children: [
            // Quantity
            Obx(() => Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: controller.decrement,
                        icon: const Icon(Icons.remove, color: AppColors.textSecondary, size: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${controller.quantity.value}',
                          style: AppTextStyles.h4,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.increment,
                        icon: const Icon(Icons.add, color: AppColors.textSecondary, size: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                )),
            const SizedBox(width: 14),
            Expanded(
              child: CustomButton(
                text: 'Add to Cart',
                variant: ButtonVariant.gradient,
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
                onTap: () {
                  final size = controller.selectedSize.value.isEmpty ? 'One Size' : controller.selectedSize.value;
                  cartCtrl.addToCart(p, size, color: controller.selectedColor.value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Stock
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: p.stock > 10 ? AppColors.success : AppColors.warning,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              p.stock > 10 ? 'In Stock' : 'Only ${p.stock} left',
              style: AppTextStyles.bodySmall.copyWith(
                color: p.stock > 10 ? AppColors.success : AppColors.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

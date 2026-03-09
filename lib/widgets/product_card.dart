import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';
import '../app/routes/app_routes.dart';
import '../data/models/product_model.dart';
import '../modules/wishlist/wishlist_controller.dart';
import '../modules/cart/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isWide;

  const ProductCard({super.key, required this.product, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    final wishlistCtrl = Get.find<WishlistController>();
    final cartCtrl = Get.find<CartController>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: isWide ? 3 : 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: AppColors.bgSurface,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bgSurface,
                        child: const Icon(Icons.image_not_supported_outlined,
                            color: AppColors.textMuted),
                      ),
                    ),
                  ),
                  // Badges
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.isNew)
                          _buildBadge('NEW', AppColors.primary),
                        if (product.hasDiscount) ...[
                          const SizedBox(height: 4),
                          _buildBadge('-${product.discountPercent.toInt()}%', AppColors.error),
                        ],
                      ],
                    ),
                  ),
                  // Wishlist
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() {
                      final isWishlisted = wishlistCtrl.isWishlisted(product.id);
                      return GestureDetector(
                        onTap: () => wishlistCtrl.toggleWishlist(product),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: isWishlisted
                                ? AppColors.error.withOpacity(0.15)
                                : AppColors.bgDark.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isWishlisted ? Icons.favorite : Icons.favorite_border,
                            color: isWishlisted ? AppColors.error : AppColors.textSecondary,
                            size: 16,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: isWide ? 2 : 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.gold, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewCount})',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: AppTextStyles.priceSmall,
                              ),
                              if (product.hasDiscount)
                                Text(
                                  '\$${product.originalPrice!.toStringAsFixed(0)}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => cartCtrl.addToCart(product, product.sizes.isNotEmpty ? product.sizes[0] : 'One Size'),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}

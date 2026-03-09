import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/utils/responsive.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/product_card.dart';
import 'wishlist_controller.dart';

class WishlistView extends StatelessWidget {
  final bool isEmbedded;
  const WishlistView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: isEmbedded
          ? null
          : AppBar(
              backgroundColor: AppColors.bgDark,
              title: Text('Wishlist', style: AppTextStyles.h3),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
                onPressed: Get.back,
              ),
            ),
      body: SafeArea(
        child: Obx(() {
          if (controller.wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.bgCard,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: const Icon(Icons.favorite_border, size: 44, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 20),
                  Text('Your wishlist is empty', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  Text('Save items you love', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 28),
                  CustomButton(
                    text: 'Browse Products',
                    variant: ButtonVariant.outline,
                    width: 180,
                    onTap: Get.back,
                  ),
                ],
              ),
            );
          }

          final crossAxis = Responsive.gridCrossAxisCount(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEmbedded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Text('Wishlist', style: AppTextStyles.h2),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${controller.wishlistItems.length} saved items', style: AppTextStyles.bodySmall),
                    GestureDetector(
                      onTap: controller.wishlistItems.clear,
                      child: Text('Clear All', style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxis,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: controller.wishlistItems.length,
                  itemBuilder: (_, i) => ProductCard(product: controller.wishlistItems[i]),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

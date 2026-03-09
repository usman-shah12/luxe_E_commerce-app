import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import 'cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgDark,
        title: Text('My Cart', style: AppTextStyles.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
          onPressed: Get.back,
        ),
        actions: [
          Obx(() => controller.cartItems.isNotEmpty
              ? TextButton(
                  onPressed: controller.clearCart,
                  child: Text('Clear', style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return _EmptyCart();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: controller.cartItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (_, i) => _CartItemCard(index: i),
              ),
            ),
            _OrderSummary(),
          ],
        );
      }),
    );
  }
}

class _CartItemCard extends GetView<CartController> {
  final int index;
  const _CartItemCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.cartItems[index];
      return Dismissible(
        key: Key(item.product.id + item.selectedSize),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => controller.removeFromCart(index),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.delete_outline, color: AppColors.error),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.product.imageUrl,
                  width: 80,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.product.name, style: AppTextStyles.labelLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('Size: ${item.selectedSize}', style: AppTextStyles.bodySmall),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${item.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.priceSmall),
                        // Quantity control
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.bgSurface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => controller.decrement(index),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.remove, size: 14, color: AppColors.textSecondary),
                                ),
                              ),
                              Text('${item.quantity}', style: AppTextStyles.labelLarge),
                              GestureDetector(
                                onTap: () => controller.increment(index),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.add, size: 14, color: AppColors.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _OrderSummary extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.borderColor, width: 0.5)),
      ),
      child: Obx(() => Column(
            children: [
              _SummaryRow('Subtotal', '\$${controller.subtotal.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              _SummaryRow(
                'Delivery',
                controller.deliveryFee == 0 ? 'FREE' : '\$${controller.deliveryFee.toStringAsFixed(2)}',
                valueColor: controller.deliveryFee == 0 ? AppColors.success : null,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.borderColor),
              ),
              _SummaryRow(
                'Total',
                '\$${controller.total.toStringAsFixed(2)}',
                isBold: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Proceed to Checkout',
                variant: ButtonVariant.gradient,
                onTap: () => Get.toNamed(AppRoutes.checkout),
              ),
            ],
          )),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow(this.label, this.value, {this.isBold = false, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? AppTextStyles.h4 : AppTextStyles.bodyMedium),
        Text(
          value,
          style: isBold
              ? AppTextStyles.priceTag.copyWith(fontSize: 18)
              : AppTextStyles.labelLarge.copyWith(color: valueColor ?? AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: const Icon(Icons.shopping_bag_outlined, size: 44, color: AppColors.textMuted),
          ),
          const SizedBox(height: 20),
          Text('Your cart is empty', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text('Add items to start shopping', style: AppTextStyles.bodyMedium),
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../cart/cart_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgDark,
        title: Text('Checkout', style: AppTextStyles.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
          onPressed: Get.back,
        ),
      ),
      body: Obx(() => Column(
            children: [
              // Step indicator
              _StepIndicator(),
              Expanded(
                child: IndexedStack(
                  index: controller.currentStep.value,
                  children: [
                    _ShippingStep(),
                    _PaymentStep(),
                    _ReviewStep(cartCtrl: cartCtrl),
                  ],
                ),
              ),
              // Bottom buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Row(
                  children: [
                    if (controller.currentStep.value > 0)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CustomButton(
                            text: 'Back',
                            variant: ButtonVariant.secondary,
                            onTap: controller.prevStep,
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 2,
                      child: controller.currentStep.value == 2
                          ? CustomButton(
                              text: 'Place Order · \$${cartCtrl.total.toStringAsFixed(2)}',
                              variant: ButtonVariant.gradient,
                              isLoading: controller.isLoading.value,
                              onTap: controller.placeOrder,
                            )
                          : CustomButton(
                              text: 'Continue',
                              variant: ButtonVariant.gradient,
                              onTap: controller.nextStep,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class _StepIndicator extends GetView<CheckoutController> {
  final steps = const ['Shipping', 'Payment', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Row(
            children: List.generate(steps.length, (i) {
              final isActive = i == controller.currentStep.value;
              final isDone = i < controller.currentStep.value;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              gradient: (isActive || isDone) ? AppColors.gradientPrimary : null,
                              color: (isActive || isDone) ? null : AppColors.bgCard,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (isActive || isDone) ? Colors.transparent : AppColors.borderColor,
                              ),
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                                  : Text(
                                      '${i + 1}',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: isActive ? Colors.white : AppColors.textMuted,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[i],
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isActive ? AppColors.primary : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i < steps.length - 1)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 1,
                          margin: const EdgeInsets.only(bottom: 18),
                          color: isDone ? AppColors.primary : AppColors.borderColor,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ));
  }
}

class _ShippingStep extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Address', style: AppTextStyles.h3),
            const SizedBox(height: 20),
            CustomTextField(hint: 'Full Name', label: 'Name', controller: controller.nameController, prefixIcon: const Icon(Icons.person_outline)),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Email', label: 'Email', controller: controller.emailController, keyboardType: TextInputType.emailAddress, prefixIcon: const Icon(Icons.mail_outline)),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Phone', label: 'Phone', controller: controller.phoneController, keyboardType: TextInputType.phone, prefixIcon: const Icon(Icons.phone_outlined)),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Street Address', label: 'Address', controller: controller.addressController, prefixIcon: const Icon(Icons.location_on_outlined)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: CustomTextField(hint: 'City', label: 'City', controller: controller.cityController)),
                const SizedBox(width: 12),
                Expanded(child: CustomTextField(hint: 'ZIP Code', label: 'ZIP', controller: controller.zipController, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PaymentStep extends GetView<CheckoutController> {
  final icons = [Icons.credit_card, Icons.paypal, Icons.apple, Icons.g_mobiledata];

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Text('Payment Method', style: AppTextStyles.h3),
            const SizedBox(height: 20),
            ...List.generate(controller.paymentMethods.length, (i) {
              final isSelected = controller.selectedPayment.value == i;
              return GestureDetector(
                onTap: () => controller.selectedPayment.value = i,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.borderColor,
                      width: isSelected ? 1.5 : 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withOpacity(0.15) : AppColors.bgSurface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icons[i], color: isSelected ? AppColors.primary : AppColors.textMuted, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Text(controller.paymentMethods[i], style: AppTextStyles.labelLarge)),
                      if (isSelected)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            gradient: AppColors.gradientPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 12),
                        ),
                    ],
                  ),
                ),
              );
            }),
            if (controller.selectedPayment.value == 0) ...[
              const SizedBox(height: 8),
              Text('Card Details', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              const CustomTextField(hint: '1234 5678 9012 3456', label: 'Card Number', prefixIcon: Icon(Icons.credit_card_outlined)),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(child: CustomTextField(hint: 'MM/YY', label: 'Expiry')),
                  SizedBox(width: 12),
                  Expanded(child: CustomTextField(hint: '•••', label: 'CVV', obscureText: true)),
                ],
              ),
            ],
          ],
        ));
  }
}

class _ReviewStep extends GetView<CheckoutController> {
  final CartController cartCtrl;
  const _ReviewStep({required this.cartCtrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Text('Order Review', style: AppTextStyles.h3),
            const SizedBox(height: 20),
            // Items
            ...cartCtrl.cartItems.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderColor, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(item.product.imageUrl, width: 60, height: 68, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.name, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('${item.selectedSize} · Qty ${item.quantity}', style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      Text('\$${item.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.priceSmall),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor, width: 0.5),
              ),
              child: Column(
                children: [
                  _Row('Subtotal', '\$${cartCtrl.subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _Row('Delivery', cartCtrl.deliveryFee == 0 ? 'FREE' : '\$${cartCtrl.deliveryFee.toStringAsFixed(2)}'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: AppColors.borderColor),
                  ),
                  _Row('Total', '\$${cartCtrl.total.toStringAsFixed(2)}', bold: true),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _Row(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bold ? AppTextStyles.h4 : AppTextStyles.bodyMedium),
        Text(value,
            style: bold
                ? AppTextStyles.priceTag.copyWith(fontSize: 18)
                : AppTextStyles.labelLarge),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = 'LX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success animation
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: AppColors.gradientPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 56),
                ),
              ),
              const SizedBox(height: 36),
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text(
                      'Order Placed!',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your order has been successfully placed\nand is being processed.',
                      style: AppTextStyles.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Order ID card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderColor, width: 0.5),
                      ),
                      child: Column(
                        children: [
                          Text('Order ID', style: AppTextStyles.bodySmall),
                          const SizedBox(height: 6),
                          Text(orderId, style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
                          const SizedBox(height: 16),
                          const Divider(color: AppColors.borderColor),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _InfoChip(Icons.local_shipping_outlined, 'Estimated\n2-3 Days'),
                              _InfoChip(Icons.location_on_outlined, 'New York,\nUS'),
                              _InfoChip(Icons.payment_outlined, 'Credit\nCard'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'Continue Shopping',
                      variant: ButtonVariant.gradient,
                      onTap: () => Get.offAllNamed(AppRoutes.home),
                    ),
                    const SizedBox(height: 14),
                    CustomButton(
                      text: 'Track Order',
                      variant: ButtonVariant.outline,
                      onTap: () => Get.offAllNamed(AppRoutes.home),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(height: 6),
        Text(label, style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
      ],
    );
  }
}

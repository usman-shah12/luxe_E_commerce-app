import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? size.width * 0.2 : 28,
              vertical: 32,
            ),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientPrimary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.diamond_outlined, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome\nBack',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Sign in to your account', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 40),
                  CustomTextField(
                    hint: 'you@email.com',
                    label: 'Email',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline),
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: '••••••••',
                    label: 'Password',
                    controller: controller.passwordController,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password?',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
                  ),
                  const SizedBox(height: 32),
                  Obx(() => CustomButton(
                        text: 'Sign In',
                        variant: ButtonVariant.gradient,
                        isLoading: controller.isLoading.value,
                        onTap: controller.login,
                      )),
                  const SizedBox(height: 24),
                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.borderColor)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or', style: AppTextStyles.bodySmall),
                      ),
                      const Expanded(child: Divider(color: AppColors.borderColor)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _SocialButton(
                    icon: Icons.g_mobiledata,
                    label: 'Continue with Google',
                    onTap: () {},
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.signup),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyles.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 22),
            const SizedBox(width: 10),
            Text(label, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

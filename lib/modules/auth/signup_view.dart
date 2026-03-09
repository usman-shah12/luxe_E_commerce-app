import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
          onPressed: Get.back,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? size.width * 0.2 : 28,
              vertical: 16,
            ),
            child: Form(
              key: controller.signupFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create\nAccount',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Join the LUXE community today', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 36),
                  CustomTextField(
                    hint: 'Full Name',
                    label: 'Name',
                    controller: controller.nameController,
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: '••••••••',
                    label: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (val) {
                      if (val != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: AppTextStyles.bodySmall,
                        children: [
                          TextSpan(
                            text: 'Terms & Privacy Policy',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(() => CustomButton(
                        text: 'Create Account',
                        variant: ButtonVariant.gradient,
                        isLoading: controller.isLoading.value,
                        onTap: controller.signup,
                      )),
                  const SizedBox(height: 28),
                  Center(
                    child: GestureDetector(
                      onTap: Get.back,
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: AppTextStyles.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Sign In',
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

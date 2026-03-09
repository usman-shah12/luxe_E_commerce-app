import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';

enum ButtonVariant { primary, secondary, outline, ghost, gradient }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: onTap == null ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          width: width ?? double.infinity,
          height: height,
          decoration: _buildDecoration(),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[icon!, const SizedBox(width: 8)],
                      Text(text, style: _textStyle()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (variant) {
      case ButtonVariant.gradient:
        return BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case ButtonVariant.primary:
        return BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        );
      case ButtonVariant.secondary:
        return BoxDecoration(
          color: AppColors.bgElevated,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.borderColor),
        );
      case ButtonVariant.outline:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.primary, width: 1.5),
        );
      case ButtonVariant.ghost:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        );
    }
  }

  TextStyle _textStyle() {
    switch (variant) {
      case ButtonVariant.outline:
        return AppTextStyles.button.copyWith(color: AppColors.primary);
      case ButtonVariant.ghost:
        return AppTextStyles.button.copyWith(color: AppColors.textSecondary);
      default:
        return AppTextStyles.button;
    }
  }
}

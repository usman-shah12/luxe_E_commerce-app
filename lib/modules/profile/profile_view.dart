import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  final bool isEmbedded;
  const ProfileView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
final controller = Get.isRegistered<ProfileController>()
    ? Get.find<ProfileController>()
    : Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: isEmbedded
          ? null
          : AppBar(
              backgroundColor: AppColors.bgDark,
              title: Text('Profile', style: AppTextStyles.h3),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
                onPressed: Get.back,
              ),
            ),
      body: Obx(() {
        final user = controller.user.value;
        return SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24, isEmbedded ? 48 : 24, 24, 32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.bgSurface, AppColors.bgDark],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.gradientPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              user.avatar,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Center(
                                child: Text(
                                  user.name[0],
                                  style: AppTextStyles.h1.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.bgCard,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: const Icon(Icons.edit, size: 14, color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(user.name, style: AppTextStyles.h2),
                    const SizedBox(height: 4),
                    Text(user.email, style: AppTextStyles.bodySmall),
                    const SizedBox(height: 20),
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const _StatChip('12', 'Orders'),
                        _Divider(),
                        const _StatChip('4', 'Reviews'),
                        _Divider(),
                        const _StatChip('8', 'Wishlist'),
                      ],
                    ),
                  ],
                ),
              ),
              // Menu
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account', style: AppTextStyles.labelMedium.copyWith(letterSpacing: 1.5)),
                    const SizedBox(height: 12),
                    _MenuGroup([
                      _MenuItem(Icons.person_outline, 'Personal Info', subtitle: user.name),
                      _MenuItem(Icons.location_on_outlined, 'Address', subtitle: user.city),
                      const _MenuItem(Icons.credit_card_outlined, 'Payment Methods'),
                      const _MenuItem(Icons.notifications_outlined, 'Notifications'),
                    ]),
                    const SizedBox(height: 20),
                    Text('Orders', style: AppTextStyles.labelMedium.copyWith(letterSpacing: 1.5)),
                    const SizedBox(height: 12),
                    const _MenuGroup([
                      _MenuItem(Icons.shopping_bag_outlined, 'My Orders'),
                      _MenuItem(Icons.repeat_outlined, 'Returns & Refunds'),
                      _MenuItem(Icons.star_outline_rounded, 'My Reviews'),
                    ]),
                    const SizedBox(height: 20),
                    Text('Support', style: AppTextStyles.labelMedium.copyWith(letterSpacing: 1.5)),
                    const SizedBox(height: 12),
                    const _MenuGroup([
                      _MenuItem(Icons.help_outline, 'Help Center'),
                      _MenuItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
                      _MenuItem(Icons.info_outline, 'About LUXE'),
                    ]),
                    const SizedBox(height: 20),
                    // Logout
                    GestureDetector(
                      onTap: controller.logout,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.error.withOpacity(0.3), width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout, color: AppColors.error, size: 20),
                            const SizedBox(width: 10),
                            Text('Sign Out', style: AppTextStyles.labelLarge.copyWith(color: AppColors.error)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  const _StatChip(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: AppColors.borderColor);
  }
}

class _MenuGroup extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuGroup(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor, width: 0.5),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(
            children: [
              e.value,
              if (!isLast) const Divider(height: 0, color: AppColors.borderColor, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _MenuItem(this.icon, this.title, {this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.bgSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelLarge),
                  if (subtitle != null)
                    Text(subtitle!, style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18),
          ],
        ),
      ),
    );
  }
}

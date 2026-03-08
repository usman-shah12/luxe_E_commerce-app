import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Page View — uses controller.pageController (not a local instance)
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (_, i) => _OnboardingPage(
              data: controller.pages[i],
              index: i,
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.bgDark.withOpacity(0.95),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // SmoothPageIndicator listens to PageController directly,
                  // no Obx needed here
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.pages.length,
                    effect: const WormEffect(
                      dotColor: AppColors.bgElevated,
                      activeDotColor: AppColors.primary,
                      dotHeight: 6,
                      dotWidth: 6,
            
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      // Skip button
                      GestureDetector(
                        onTap: controller.complete,
                        child: Text(
                          'Skip',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Next / Get Started — Obx only here because
                      // isLastPage reads currentPage.obs
                      Obx(
                        () => GestureDetector(
                          onTap: controller.next,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: controller.isLastPage ? 160 : 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientPrimary,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: controller.isLastPage
                                  ? Text(
                                      'Get Started',
                                      style: AppTextStyles.button
                                          .copyWith(fontSize: 14),
                                    )
                                  : const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
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
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final Map<String, String> data;
  final int index;

  const _OnboardingPage({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.network(
          data['image']!,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Container(color: AppColors.bgSurface);
          },
        ),

        // Dark overlay gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0x800A0A0F),
                Color(0xCC0A0A0F),
                Color(0xFF0A0A0F),
              ],
              stops: [0.0, 0.4, 0.65, 1.0],
            ),
          ),
        ),

        // Text content
        Positioned(
          bottom: 160,
          left: 28,
          right: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title']!,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: size.width > 600 ? 56 : 44,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data['subtitle']!,
                style: AppTextStyles.bodyLarge.copyWith(height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
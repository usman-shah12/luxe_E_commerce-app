
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:luxe_shop/app/theme/app_colors.dart';
import 'package:luxe_shop/app/theme/text_styles.dart';
import 'package:luxe_shop/modules/search/search_controller.dart' as sc;

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageUrl,
    required this.productCount,
  });
}




class _CategoryChip extends GetView<sc.LuxeSearchController> {
  final CategoryModel category;
  const _CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onSearch(category.name),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.bgCard),
            ),
            // Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Emoji + label
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.icon, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 2),
                  Text(
                    category.name,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
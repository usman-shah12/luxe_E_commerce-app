// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luxe_shop/data/services/dummy_data.dart';
// import '../../app/theme/app_colors.dart';
// import '../../app/theme/text_styles.dart';
// import '../../app/utils/responsive.dart';
// import '../../widgets/product_card.dart';
// import 'search_controller.dart' as sc;

// class SearchView extends StatelessWidget {
//   final bool isEmbedded;
//   const SearchView({super.key, this.isEmbedded = false});

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.find<sc.LuxeSearchController>();
//     final controller = Get.isRegistered<sc.LuxeSearchController>()
//     ? Get.find<sc.LuxeSearchController>()
//     : Get.put(sc.LuxeSearchController());
//     return Scaffold(
//       backgroundColor: AppColors.bgDark,
//       appBar: isEmbedded ? null : AppBar(
//         backgroundColor: AppColors.bgDark,
//         title: Text('Search', style: AppTextStyles.h3),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 18),
//           onPressed: Get.back,
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (isEmbedded)
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
//                 child: Text('Search', style: AppTextStyles.h2),
//               ),
//             // Search bar
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
//               child: Obx(() => TextField(
//                     onChanged: controller.onSearch,
//                     style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
//                     decoration: InputDecoration(
//                       hintText: 'Search products...',
//                       prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 22),
//                       suffixIcon: controller.query.value.isNotEmpty
//                           ? GestureDetector(
//                               onTap: controller.clearSearch,
//                               child: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
//                             )
//                           : null,
//                     ),
//                   )),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Obx(() {
//                 if (controller.query.value.isEmpty) {
//                   return _EmptyState(controller: controller);
//                 }
//                 if (controller.results.isEmpty) {
//                   return _NoResults(query: controller.query.value);
//                 }
//                 return _Results(controller: controller, context: context);
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EmptyState extends StatelessWidget {
//   final sc.LuxeSearchController controller;
//   const _EmptyState({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Recent Searches', style: AppTextStyles.h4),
//           const SizedBox(height: 12),
//           Obx(() => Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: controller.recentSearches
//                     .map((term) => GestureDetector(
//                           onTap: () => controller.searchRecent(term),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: AppColors.bgCard,
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: AppColors.borderColor, width: 0.5),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.history, size: 14, color: AppColors.textMuted),
//                                 const SizedBox(width: 6),
//                                 Text(term, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
//                               ],
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               )),
//           const SizedBox(height: 28),
//           // Text('Popular Categories', style: AppTextStyles.h4),
//           // const SizedBox(height: 12),
//           // GridView.count(
//           //   crossAxisCount: 2,
//           //   shrinkWrap: true,
//           //   physics: const NeverScrollableScrollPhysics(),
//           //   crossAxisSpacing: 12,
//           //   mainAxisSpacing: 12,
//           //   childAspectRatio: 2.5,
//           //   children: const [
//           //     _CategoryChip('👗 Fashion', 'fashion'),
//           //     _CategoryChip('⌚ Accessories', 'accessories'),
//           //     _CategoryChip('👟 Footwear', 'footwear'),
//           //     _CategoryChip('👜 Bags', 'bags'),
//           //   ],
//           // ),
//           // Replace the GridView.count for categories with this:
// Text('Popular Categories', style: AppTextStyles.h4),
// const SizedBox(height: 12),
// GridView.builder(
//   shrinkWrap: true,
//   physics: const NeverScrollableScrollPhysics(),
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     crossAxisSpacing: 12,
//     mainAxisSpacing: 12,
//     childAspectRatio: 1.1,
//   ),
//   itemCount: DummyData.categories.length,
//   itemBuilder: (_, i) => _CategoryChip(DummyData.categories[i].name, DummyData.categories[i].id),
// ),
//         ],
//       ),
//     );
//   }
// }

// class _CategoryChip extends GetView<sc.LuxeSearchController> {
//   final String label;
//   final String id;
//   const _CategoryChip(this.label, this.id);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => controller.onSearch(id),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.bgCard,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.borderColor, width: 0.5),
//         ),
//         child: Center(child: Text(label, style: AppTextStyles.labelMedium)),
//       ),
//     );
//   }
// }

// class _NoResults extends StatelessWidget {
//   final String query;
//   const _NoResults({required this.query});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.search_off_rounded, size: 56, color: AppColors.textMuted),
//           const SizedBox(height: 16),
//           Text('No results for "$query"', style: AppTextStyles.h4),
//           const SizedBox(height: 8),
//           Text('Try a different search term', style: AppTextStyles.bodyMedium),
//         ],
//       ),
//     );
//   }
// }

// class _Results extends GetView<sc.LuxeSearchController> {
//   final BuildContext context;
//   const _Results({required sc.LuxeSearchController controller, required this.context})
//       : super();

//   @override
//   Widget build(BuildContext _) {
//     return Obx(() {
//       final crossAxis = Responsive.gridCrossAxisCount(context);
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               '${controller.results.length} results found',
//               style: AppTextStyles.bodySmall,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxis,
//                 childAspectRatio: 0.62,
//                 crossAxisSpacing: 14,
//                 mainAxisSpacing: 14,
//               ),
//               itemCount: controller.results.length,
//               itemBuilder: (_, i) => ProductCard(product: controller.results[i]),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxe_shop/data/models/category_model.dart';
import 'package:luxe_shop/data/services/dummy_data.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/utils/responsive.dart';
import '../../widgets/product_card.dart';
import 'search_controller.dart' as sc;

class SearchView extends StatelessWidget {
  final bool isEmbedded;
  const SearchView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<sc.LuxeSearchController>()
        ? Get.find<sc.LuxeSearchController>()
        : Get.put(sc.LuxeSearchController());
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: isEmbedded
          ? null
          : AppBar(
              backgroundColor: AppColors.bgDark,
              title: Text('Search', style: AppTextStyles.h3),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.textPrimary, size: 18),
                onPressed: Get.back,
              ),
            ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEmbedded)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text('Search', style: AppTextStyles.h2),
              ),
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Obx(() => TextField(
                 controller: controller.textController,
                    onChanged: controller.onSearch,
                    style: AppTextStyles.bodyLarge
                        .copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.textMuted, size: 22),
                      suffixIcon: controller.query.value.isNotEmpty
                          ? GestureDetector(
                              onTap: controller.clearSearch,
                              child: const Icon(Icons.close,
                                  color: AppColors.textMuted, size: 18),
                            )
                          : null,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.query.value.isEmpty) {
                  return _EmptyState(controller: controller);
                }
                if (controller.results.isEmpty) {
                  return _NoResults(query: controller.query.value);
                }
                return _Results(controller: controller, context: context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final sc.LuxeSearchController controller;
  const _EmptyState({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Skip the 'All' category chip (index 0) — show only real categories
    final categories = DummyData.categories
        .where((c) => c.id != 'all')
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Searches', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.recentSearches
                    .map((term) => GestureDetector(
                          onTap: () => controller.searchRecent(term),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.bgCard,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.borderColor, width: 0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.history,
                                    size: 14, color: AppColors.textMuted),
                                const SizedBox(width: 6),
                                Text(
                                  term,
                                  style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )),
          const SizedBox(height: 28),
          Text('Popular Categories', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            itemBuilder: (_, i) => _CategoryChip(categories[i]),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends GetView<sc.LuxeSearchController> {
  final CategoryModel category;
  const _CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onSearch(category.name),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.bgCard),
            ),
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.65),
                  ],
                ),
              ),
            ),
            // Emoji + label
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category.icon,
                      style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

class _NoResults extends StatelessWidget {
  final String query;
  const _NoResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded,
              size: 56, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text('No results for "$query"', style: AppTextStyles.h4),
          const SizedBox(height: 8),
          Text('Try a different search term',
              style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}

class _Results extends GetView<sc.LuxeSearchController> {
  final BuildContext context;
  const _Results(
      {required sc.LuxeSearchController controller, required this.context})
      : super();

  @override
  Widget build(BuildContext _) {
    return Obx(() {
      final crossAxis = Responsive.gridCrossAxisCount(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${controller.results.length} results found',
              style: AppTextStyles.bodySmall,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 2.2,
),
              itemCount: controller.results.length,
              itemBuilder: (_, i) =>
                  ProductCard(product: controller.results[i]),
            ),
          ),
        ],
      );
    });
  }
}
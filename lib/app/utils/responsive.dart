import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double devicePixelRatio;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double wp(BuildContext context, double percent) =>
      MediaQuery.of(context).size.width * percent / 100;

  static double hp(BuildContext context, double percent) =>
      MediaQuery.of(context).size.height * percent / 100;

  /// Responsive value: returns tablet value if tablet, else mobile value
  static T value<T>(BuildContext context, {required T mobile, T? tablet, T? desktop}) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  // Product grid cross-axis count
  static int gridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    return 2;
  }
}

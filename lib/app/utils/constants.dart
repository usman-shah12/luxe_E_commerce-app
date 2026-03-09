class AppConstants {
  // App Info
  static const appName = 'LUXE';
  static const appTagline = 'Premium Shopping Redefined';

  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 100.0;

  // Animation Duration
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 600);

  // SharedPrefs Keys
  static const String keyOnboarded = 'is_onboarded';
  static const String keyLoggedIn = 'is_logged_in';

  // Product Sizes
  static const List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  // Sort Options
  static const List<String> sortOptions = [
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
    'Top Rated',
    'Most Popular',
  ];
}

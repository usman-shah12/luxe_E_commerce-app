# 🛍️ LUXE Shop — Premium Flutter E-Commerce App

A production-ready, single vendor e-commerce Flutter application built for portfolio use. Features a stunning dark luxury theme, GetX state management, clean architecture, and smooth animations.

---

## ✨ Features

| Screen | Description |
|--------|-------------|
| **Splash** | Animated logo with progress bar |
| **Onboarding** | 3-page full-screen image flow with skip/next |
| **Login / Signup** | Form validation, social login UI |
| **Home** | Banner carousel, categories, featured & all products |
| **Product Detail** | Image gallery, size/color picker, quantity selector |
| **Cart** | Swipe-to-delete, quantity controls, order summary |
| **Checkout** | 3-step flow: Shipping → Payment → Review |
| **Order Success** | Animated confirmation with order details |
| **Search** | Live search, recent searches, category shortcuts |
| **Wishlist** | Add/remove, persisted via GetX |
| **Profile** | User info, orders, settings, sign out |

---

## 🏗️ Architecture

```
lib/
├── main.dart
├── app/
│   ├── routes/         # AppRoutes + AppPages (GetX routing)
│   ├── theme/          # Colors, text styles, theme
│   └── utils/          # Constants, responsive helpers
├── data/
│   ├── models/         # ProductModel, CategoryModel, UserModel
│   └── services/       # DummyData (JSON-like static data)
├── modules/            # Feature modules (MVC per feature)
│   ├── splash/         # controller + binding + view
│   ├── onboarding/
│   ├── auth/
│   ├── home/
│   ├── product/
│   ├── cart/
│   ├── checkout/
│   ├── order_success/
│   ├── search/
│   ├── wishlist/
│   └── profile/
└── widgets/            # Reusable UI components
    ├── custom_button.dart
    ├── custom_textfield.dart
    ├── product_card.dart
    └── loading_widget.dart
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Setup

```bash
# Clone and navigate
cd luxe_shop

# Install dependencies
flutter pub get

# Run
flutter run
```

### First Launch Flow
The app checks SharedPreferences on splash:
- First time → **Onboarding** → Login
- Returning (not logged in) → **Login**
- Returning (logged in) → **Home**

---

## 📦 Packages Used

| Package | Purpose |
|---------|---------|
| `get ^4.6.6` | State management, routing, DI |
| `google_fonts ^6.2.1` | Outfit + Cormorant Garamond fonts |
| `carousel_slider ^4.2.1` | Home banner slider |
| `smooth_page_indicator ^1.1.0` | Dot indicators |
| `flutter_rating_bar ^4.0.1` | Star ratings |
| `cached_network_image ^3.3.1` | Efficient image loading |
| `shimmer ^3.0.0` | Loading skeletons |
| `shared_preferences ^2.2.2` | Persist onboarding/login state |

---

## 🎨 Design System

- **Theme**: Dark luxury with purple (`#7C3AED`) + gold (`#D4AF37`) accents  
- **Fonts**: Cormorant Garamond (display) + Outfit (body)  
- **Cards**: Glassmorphism-inspired dark cards with subtle borders  
- **Animations**: Fade/slide transitions, elastic success animation, staggered loading  
- **Responsive**: 2-column mobile grid → 3-column tablet → 4-column desktop  

---

## 🔧 Extending with Firebase

To upgrade from dummy data to Firebase:

1. Add `firebase_core`, `cloud_firestore`, `firebase_auth` to `pubspec.yaml`
2. Replace `DummyData` service with Firestore repository classes
3. Update `AuthController.login()` / `signup()` to use `FirebaseAuth`
4. Keep all views/controllers unchanged — only the data layer changes

---

## 📱 Screenshots

> Run on a device or emulator to see the full experience with network images.

---

*Built with ❤️ using Flutter & GetX*

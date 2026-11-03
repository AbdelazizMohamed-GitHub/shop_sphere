# 🛍️ ShopSphere

ShopSphere is a modern **e-commerce application** built with **Flutter**. It lets users browse products, add items to their cart, place orders, and manage their profile and delivery addresses. It also includes an **admin dashboard** with analytics, product management, customer management, and staff management.

The app runs on **Android, iOS, Web, Windows, macOS, and Linux** from a single codebase.

---

## ✨ Features

### 👤 User Side
- 🛒 **Product Browsing:** Explore products by category and filters.
- 🔍 **Smart Search:** Search products by name, category, or keywords.
- ❤️ **Wishlist & Favorites:** Save products for later.
- 🛍️ **Cart Management:** Add, update, or remove items.
- 💳 **Checkout Flow:** Place orders with a smooth checkout experience.
- 📍 **Address Management:** Add and edit delivery addresses.
- 🔔 **Push Notifications:** Get updates on offers and order status.

### 🛠️ Admin Side
- 📊 **Analytics Dashboard:** Track sales, revenue, and orders by day, week, month, or year.
- 📦 **Product Management:** Add, update, or remove products.
- 👥 **Customer Management:** View and manage customers.
- 👷 **Staff Management:** Manage staff accounts and their products.
- 🧾 **Order Management:** Track and update order statuses.

---

## 🛠️ Tech Stack

- **Flutter** & **Dart**
- **Firebase** (Authentication, Firestore, Push Notifications)
- **BLoC** for state management
- **Clean Architecture**
- **Hive** for local storage
- **Supabase Storage** for product images

---

## 📸 Screenshots

### 👤 User Side

| Explore | Orders | Profile | Notifications |
| --- | --- | --- | --- |
| <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Explor.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Order.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Profile.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Notification.jpg" width="200"> |

| Product Details | Checkout | Address |
| --- | --- | --- |
| <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Details.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/CheckOut.png" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Address.jpg" width="200"> |

### 🛠️ Admin Side

| Dashboard | Analytics | Add / Edit Product | Customers |
| --- | --- | --- | --- |
| <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Dashboard.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Analytics.png" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Edit%20or%20Add%20Product.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Customers.jpg" width="200"> |

| Customer Profile | Staff | Staff Products | Send Notification |
| --- | --- | --- | --- |
| <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/CustomerProfile.jpg" width="200"> | <img src="https://oydjpuirgaaxururbnxc.supabase.co/storage/v1/object/public/ShopSphere%20Screen/Staff.jpg" width="200"> | <img

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version X.X.X or later)
- Dart SDK (included with Flutter)
- A Firebase project
- Android Studio or VS Code with the Flutter extension

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/AbdelazizMohamed-GitHub/shop_sphere.git
cd shop_sphere

# 2. Install dependencies
flutter pub get

# 3. Connect the project to Firebase
dart pub global activate flutterfire_cli
flutterfire configure

# 4. Run the app
flutter run
```

To run on a specific platform, use `flutter run -d chrome` for Web, or `flutter run -d windows` for Windows.

---

## 📁 Project Structure   

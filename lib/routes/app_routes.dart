import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/all_banner/banner.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/create_banner/create_banner.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/categories.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/create_category/create_category.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/edit_category/edit_category.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/all_customers/customers.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/forget_password/forget_password.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/all_orders/orders.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/create_product.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/edit_product/edit_product.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/rest_password.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/dashboard_screen.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/settings/settings.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes_middleware.dart';

import '../features/screens/banner/edit_banner/edit_banner.dart';
import '../features/screens/brand/all_brands/brands.dart';
import '../features/screens/brand/create_brand/create_brand.dart';
import '../features/screens/brand/edit_brand/edit_brand.dart';
import '../features/screens/customer/customer_detall/customer.dart';
import '../features/screens/order/orders_detail/order_detail.dart';
import '../features/screens/product/all_products/products.dart';
import '../features/screens/profile/profile.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.restPassword, page: () => const RestPasswordScreen()),
    GetPage(
        name: TRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [TRouteMiddleware()]),

    // Categories
    GetPage(
        name: TRoutes.categories,
        page: () => const CategoriesScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.createCategory,
        page: () => const CreateCategoryScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.editCategory,
        page: () => const EditCategoryScreen(),
        middlewares: [TRouteMiddleware()]),

        // Brands

GetPage(name: TRoutes.brands, page: () => const BrandsScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.createBrand, page: () => const CreateBrandScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.editBrand, page: () => const EditBrandScreen(), middlewares: [TRouteMiddleware()]),

// Banners

GetPage(name: TRoutes.banners, page: () => const BannersScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [TRouteMiddleware()]),

/// Products
GetPage(name: TRoutes.products, page: () => const ProductsScreen(), middlewares: [TRouteMiddleware()]),
GetPage(name: TRoutes.createProduct, page: () => const CreateProductScreen(), middlewares: [TRouteMiddleware()]),
GetPage(name: TRoutes.editProduct, page: () => const EditProductScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.customers, page: () => const CustomersScreen(), middlewares: [TRouteMiddleware()]),
GetPage(name: TRoutes.customerDetails, page: () => const CustomerDetailScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.orders, page: () => const OrdersScreen(), middlewares: [TRouteMiddleware()]),
GetPage(name: TRoutes.orderDetails, page: () => const OrderDetailScreen(), middlewares: [TRouteMiddleware()]),

GetPage(name: TRoutes.settings, page: () => const SettingsScreen(), middlewares: [TRouteMiddleware()]),
GetPage(name: TRoutes.profile, page: () => const ProfileScreen(), middlewares: [TRouteMiddleware()]),

  ];
}

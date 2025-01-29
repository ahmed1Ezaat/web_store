import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/categories.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/create_category/create_category.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/edit_category/edit_category.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/forget_password/forget_password.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/rest_password.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/dashboard_screen.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes_middleware.dart';

import '../features/screens/brand/all_brands/brands.dart';

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

  ];
}

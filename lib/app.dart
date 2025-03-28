import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/general_bindings.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/text_strings.dart';

import 'common/styles/app_theme.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lighttheme,
      darkTheme: TAppTheme.darktheme,
      getPages: TAppRoute.pages,
      initialBinding: GeneralBindings(),
      initialRoute: TRoutes.dashboard,
      unknownRoute: GetPage(name: '/page-not-found', page: ()=> const Scaffold(body: Center(child: Text('Page Not Found'),)),
      ),
    );
  }
}

  
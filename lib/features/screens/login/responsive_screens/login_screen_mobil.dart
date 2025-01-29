import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/widgets/login_form.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/widgets/login_header.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class LoginScreenMobil extends StatelessWidget {
  const LoginScreenMobil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TLoginHeader(),
          TLoginForm(),
            ],
          )
        )
      )
    );
  }
}
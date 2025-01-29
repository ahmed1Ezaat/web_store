import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/login_templates.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/widgets/login_form.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/widgets/login_header.dart';
class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplates(
      child: Column(
        children: [
          TLoginHeader(),
          TLoginForm(),
        ],
      ),
      );
  }
}

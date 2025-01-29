import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/login_templates.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/forget_password/widgets/header_form.dart';

class FotgetPasswordDesktopTablet extends StatelessWidget {
  const FotgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return  const TLoginTemplates(
      child: HeaderAndForm(),
      
      );
  }
}

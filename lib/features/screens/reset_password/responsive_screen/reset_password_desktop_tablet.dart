import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/reset_password_widget.dart';

import '../../../../common/widgets/layouts/templates/login_templates.dart';

class ResetPasswordDesktopTablet extends StatelessWidget {
  const ResetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {

    return  const TLoginTemplates(
      child: ResetPasswordWidget(),
      
      );
  }
}
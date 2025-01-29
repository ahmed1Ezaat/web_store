import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/forget_password/widgets/header_form.dart';

import '../../../../utils/constants/sizes.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: HeaderAndForm(),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/profile/profile_tablet.dart';

import '../../../common/widgets/layouts/templates/site_layout.dart';
import '../profile/profile_mobile.dart';
import 'sttings_desktop.dart';


class SettingsScreen extends StatelessWidget { 
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(), 
    );
  }
}
import 'package:flutter/material.dart';

import '../../../common/widgets/layouts/templates/site_layout.dart';
import 'profile_desktop.dart';
import 'profile_mobile.dart';
import 'profile_tablet.dart';

class ProfileScreen extends StatelessWidget { 
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(), 
    );
  }
}
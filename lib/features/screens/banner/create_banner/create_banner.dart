import 'package:flutter/widgets.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/create_banner/create_banner_mobile.dart';

import 'create_banner_desketop.dart';
import 'create_banner_tablet.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile: CreateBannerMobileScreen(),
    );
  }
}

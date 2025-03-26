import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/all_banner/banner_tablet.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'banner_desktop.dart';
import 'banner_mobile.dart';

class BannersScreen extends StatelessWidget {
    const BannersScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return const TSiteTemplate(desktop: BannersDesktopScreen(), tablet: BannersTabletScreen(), mobile: BannersMobileScreen());
    }
}
        
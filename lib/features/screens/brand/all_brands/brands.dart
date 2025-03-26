import 'package:flutter/widgets.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/all_brands/brands_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'brands_desktop.dart';
import 'brands_tablet.dart';

class BrandsScreen extends StatelessWidget {
    const BrandsScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return const TSiteTemplate(desktop: BrandsDesktopScreen(), tablet: BrandsTabletScreen(), mobile: BrandsMobileScreen());
    }
}
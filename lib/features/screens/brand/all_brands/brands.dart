import 'package:flutter/widgets.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'brands_desktop.dart';

class BrandsScreen extends StatelessWidget {
    const BrandsScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return const TSiteTemplate(desktop: BrandsDesktopScreen(), tablet: BrandsTabletScreen(), mobile: BrandsMobileScreen());
    }
}
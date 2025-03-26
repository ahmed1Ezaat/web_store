import 'package:flutter/widgets.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/all_products/products_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'products_desktop.dart';
import 'products_tablet.dart';


class ProductsScreen extends StatelessWidget {
    const ProductsScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return const TSiteTemplate(desktop: ProductsDesktopScreen(), tablet: ProductsTabletScreen(), mobile: ProductsMobileScreen());
    }
}
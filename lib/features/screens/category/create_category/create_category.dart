import 'package:flutter/widgets.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/create_category/cateate_desktop.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'cateate_mobile.dart';
import 'cateate_tablet.dart';

class CreateCategoryScreen extends StatelessWidget {
    const CreateCategoryScreen({super.key});
    
    @override
    Widget build(BuildContext context) {
        return const TSiteTemplate(
            desktop: CreateCategoryDesktopScreen(),
            tablet: CreateCategoryTabletScreen(),
            mobile: CreateCategoryMobileScreen(),
        );
    }
}
   
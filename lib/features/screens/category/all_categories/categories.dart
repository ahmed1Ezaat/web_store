import 'package:flutter/widgets.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'categories_desktop.dart';
import 'categories_mobile.dart';
import 'categories_tablet.dart';

class CategoriesScreen extends StatelessWidget {

const CategoriesScreen({super.key});


@override

Widget build(BuildContext context) {

return const TSiteTemplate(desktop: CategoriesDesktopScreen(), tablet: CategoriesTabletScreen(), mobile: CategoriesMobileScreen());

}

}
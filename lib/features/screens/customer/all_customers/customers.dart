import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'categories_desktop.dart';
import 'categories_mobile.dart';
import 'categories_tablet.dart';

class CustomersScreen extends StatelessWidget {
const CustomersScreen({super.key});
@override
Widget build(BuildContext context) {
return const TSiteTemplate(desktop: CustomersDesktopScreen(), tablet: CustomersTabletScreen(), mobile: CustomersMobileScreen());
}
}
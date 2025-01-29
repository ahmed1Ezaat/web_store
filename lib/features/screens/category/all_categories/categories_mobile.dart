
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

    import '../../../../common/widgets/containers/rounded_container.dart';
    import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import 'data_table.dart';

    class CategoriesMobileScreen extends StatelessWidget {
    const CategoriesMobileScreen({super.key});
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Breadcrumbs
                            const TBreadcrumbWithHeading(heading: 'Categories', breadcrumbItems: ['Categories']),
                            const SizedBox(height: TSizes.spaceBtwSection),
                            // Table Body
                            // Loader
                             TRoundedContainer(
                              child: Column(
                              children: [
                                      // Table Header
                              TTableHeader(buttonText: 'Create New Category', onPressed: ()=> Get.toNamed(TRoutes.createCategory),),
                              const SizedBox(height: TSizes.spaceBtwItem),
                                      // Table 
                              CategoryTable(),

                            ],
                        ),
                    ),
                    ],
                    ),
                ),
            ),
        );
    }
}

        
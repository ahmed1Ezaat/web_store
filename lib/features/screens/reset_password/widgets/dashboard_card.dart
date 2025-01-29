import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/headers/section_heading.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/sizes.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key, 
    
     required this.title,
      required this.subTitle, 
       this.icon = Iconsax.arrow_up_3,
        this.color = TColors.success,
        required this.stats,
       this.onTap
       });
  final String title, subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function() ?onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          TSectionHeading(title: title, textColor: TColors.textSecondary),
          SizedBox(height: TSizes.spaceBtwSection),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: TSizes.iconSm),
                        Text('$stats%', style: Theme.of(context).textTheme.titleLarge!.apply(color: color, overflow: TextOverflow.ellipsis)),
                      ]
                    ),
                  ),

                    SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Dec 2025',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow:TextOverflow.ellipsis
                    ),
                  )
               ],
              )
            ]
          )
        ]
      )
    );
  }
}

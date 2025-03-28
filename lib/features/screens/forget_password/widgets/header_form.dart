
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header
        IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: TSizes.spaceBtwItem),
        Text(TTexts.forgotPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: TSizes.spaceBtwItem),
        Text(TTexts.forgotPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: TSizes.spaceBtwSection * 2),
    
        // form
        Form(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
    
        // submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: ()=> Get.toNamed(TRoutes.restPassword, parameters: {'email':'some@gmil.com'}), child: const Text(TTexts.submit)),
        ),
        const SizedBox(height: TSizes.spaceBtwSection * 2),
      ],
    );
  }
}
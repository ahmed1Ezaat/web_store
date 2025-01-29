

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';

    return Column(
      children: [
        // header
        Row(
          children: [
            IconButton(onPressed: ()=> Get.offAllNamed(TRoutes.login), icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
    
        // imge
        const Image(image: AssetImage(TImages.deliveredEmailIllustrion),width: 300, height: 300,),
        const SizedBox(height: TSizes.spaceBtwItem),
    
        // title
        Text(TTexts.changYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
        const SizedBox(height: TSizes.spaceBtwItem),
        Text(email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: TSizes.spaceBtwItem),
        Text(
          TTexts.changYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
    
        // Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(TRoutes.login),
            child: const Text(TTexts.done),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        SizedBox(
          width: double.infinity,
          child: TextButton(onPressed: (){}, 
          child: const Text(TTexts.resendEmail)),
          )
      ],
    );
  }
}
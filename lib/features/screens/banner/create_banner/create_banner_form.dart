import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/create_banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../routes/app_screens.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text('Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSection),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                Obx(
                  ()=> GestureDetector(
                    onTap: () => controller.pickImage(),
                    child:  TRoundedImage(
                      width: 400,
                      height: 200,
                      backgroundColor: TColors.primaryBackground,
                      image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                      imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                TextButton(onPressed: () => controller.pickImage(), child: const Text('Select Image')),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputField),

            Text('Make your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              ()=> CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) => controller.isActive.value = value ?? false,
                  child: const Text('Active')),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField),


            Obx(
              () {
                 return DropdownButton<String>(
                  value: controller.targetScreen.value,
                  onChanged: (String? newValue) => controller.targetScreen.value = newValue!,
                  items: AppScreens.allAppScreenItems
                      .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(BannerController.instance.formatRoute(value)));
                      } )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputField * 2),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () => controller.createBanner(), child: const Text('Create')),
            ),
// SizedBox
            const SizedBox(
              height: TSizes.spaceBtwInputField * 2,
            ),
          ],
        ),
      ),
    );
  }
}

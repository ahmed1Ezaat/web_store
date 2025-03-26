import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_choice_chips.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/edit_brand_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

import '../../../../data/models/brand_model.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../login/responsive_screens/widgets/validation.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);
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
            Text('update brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSection),
            // Name Text Field
            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField),
            // categories
            Text(
              'Select Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwInputField / 2),
            Obx(
              ()=> Wrap(
                spacing: TSizes.sm,
                children: CategoryController.instance.allItems
                    .map((element) => 
                  Padding(
                    padding: const EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(
                        text: element.name,
                        selected: controller.selectedCategories.contains(element),
                        onSelected: (value) => controller.toggleSelection(element),
                    ),
                  )
                ).toList(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField * 2),

            // Image Uploader & Featured Checkbox
            Obx(
              ()=> TImageUploader(
                width: 80,
                height: 80,
                image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                onIconButtonPressed: () => controller.pickImage(),
              ),
            ),
            // TImageUploader
            const SizedBox(height: TSizes.spaceBtwInputField),
            //Checkbox
            Obx(
            ()=> CheckboxMenuButton(
                  value: controller.isFeatured.value,
                  onChanged: (value) => controller.isFeatured.value = value ?? false,
                  child: const Text('Featured')),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField * 2),

//Button
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () => controller.updateBrand(brand), child: const Text('Ubdate')),
            ), // SizedBox

            const SizedBox(height: TSizes.spaceBtwInputField * 2),
          ],
        ),
      ),
    );
  }
}

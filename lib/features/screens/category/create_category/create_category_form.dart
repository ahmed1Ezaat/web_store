import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/shimmer.dart';

import '../../../../common/widgets/images/image_uploader.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../login/responsive_screens/widgets/validation.dart';
import 'create_category_controller.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return TRoundedContainer(
        width: 500,
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
            key: createController.formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// Heading
          const SizedBox(height: TSizes.sm),
          Text('Create New Category',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSection),
// Name Text Field
          TextFormField(
            controller: createController.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
          ),

          const SizedBox(height: TSizes.spaceBtwInputField),

          Obx(
            () => categoryController.isLoading.value ?
            const TShimmerEffect(width: double.infinity, height: 55) 
            : DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText: 'Parent Category',
            
                  labelText: 'Parent Category',
            
                  prefixIcon: Icon(Iconsax.bezier),
            
                ),
                onChanged: (newValue) => createController.selectedParent.value = newValue!,
                items: categoryController.allItems
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(item.name)]),
                      ),
                    )
                    .toList()),
          ),
          const SizedBox(height: TSizes.spaceBtwInputField * 2),
          Obx(
            ()=> TImageUploader(
                width: 80,
                height: 80,
                image: createController.imageURL.value.isNotEmpty ? createController.imageURL.value : TImages.defaultImage,
                imageType: createController.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                onIconButtonPressed: () => createController.pickImage()
                ),
                ),
          const SizedBox(height: TSizes.spaceBtwInputField),
          Obx(
            ()=> CheckboxMenuButton(
              value: createController.isFeatured.value,
              onChanged: (value) => createController.isFeatured.value = value ?? false,
              child: const Text('Featured'),
            ),
          ), 
          const SizedBox(height: TSizes.spaceBtwInputField * 2),
          SizedBox(
            width: double.infinity,
            child:
            ElevatedButton(onPressed: () => createController.createCategory(), child: const Text('Create')),
          ),

          const SizedBox(height: TSizes.spaceBtwInputField),

          const SizedBox(height: TSizes.spaceBtwInputField * 2),
        ])));
  }
}

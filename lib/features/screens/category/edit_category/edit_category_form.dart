import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/image_uploader.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../login/responsive_screens/widgets/validation.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        width: 500,
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// Heading
          const SizedBox(height: TSizes.sm),
          Text('Ubdate  Category',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSection),
// Name Text Field
          TextFormField(
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
          ),

          const SizedBox(height: TSizes.spaceBtwInputField),

          DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: 'Parent Category',

                labelText: 'Parent Category',

                prefixIcon: Icon(Iconsax.bezier),

                // InputDecoration
              ),
              onChanged: (newValue) {},
              items: const [
                DropdownMenuItem(
                  value: '',

                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text('item.name')]),

                  // DropdownMenuItem
                ),

                // DropdownButtonFormField
              ]),

          const SizedBox(height: TSizes.spaceBtwInputField * 2),
          TImageUploader(
              width: 80,
              height: 80,
              image: TImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {}),
          CheckboxMenuButton(
            value: true,
            onChanged: (value) {},
            child: const Text('Featured'),
          ), // checkboxMenuButton
          const SizedBox(height: TSizes.spaceBtwInputField * 2),
          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Create')),
          ),

          const SizedBox(height: TSizes.spaceBtwInputField),

          const SizedBox(height: TSizes.spaceBtwInputField * 2),
        ])));
  }
}

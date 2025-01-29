import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/containers/rounded_choice_chips.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/image_uploader.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key,});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text('Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSection),
            // Name Text Field
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField),
            // categories
            Text('Select Categories', style: Theme.of(context).textTheme.titleMedium,
                ),
            const SizedBox(height: TSizes.spaceBtwInputField / 2),
            Wrap(
              spacing: TSizes.sm,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: TSizes.sm),
                  child: TChoiceChip(
                      text: 'Shoes', selected: true, onSelected: (value) {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: TSizes.sm),
                  child: TChoiceChip(
                      text: 'Track Suits',
                      selected: false,
                      onSelected: (value) {}),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputField * 2),

            // Image Uploader & Featured Checkbox
            TImageUploader(
              width: 80,
              height: 80,
              image: TImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {},
            ),
            // TImageUploader
            const SizedBox(height: TSizes.spaceBtwInputField),
            //Checkbox
            CheckboxMenuButton(
                value: true,
                onChanged: (value) {},
                child: const Text('Featured')),
            const SizedBox(height: TSizes.spaceBtwInputField * 2),

//Button
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Ubdate')),
            ), // SizedBox

            const SizedBox(height: TSizes.spaceBtwInputField * 2),
          ],
        ),
      ),
    );
  }
}

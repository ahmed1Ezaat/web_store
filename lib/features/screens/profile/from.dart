import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/user_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../login/responsive_screens/widgets/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phomeController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              // First and Last Name
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              label: Text('First Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputField),
                        // Last Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              label: Text('Last Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'Last Name', value),
                          ),
                        ),
                      ],
                    ),
                    // Add more form fields if needed
                    const SizedBox(height: TSizes.spaceBtwInputField),
                    Row(
                      children: [
                        // Email
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false, // Kept if intentionally disabled
                            ),
                            initialValue: UserController.instance.user.value.email,
                          ),
                        ),
                        const SizedBox(
                            width: TSizes.spaceBtwItem), // Fixed constant name

                        // Phone Number
                        Expanded(
                          child: TextFormField(
                            controller: controller.phomeController,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              label: Text('Phone Number'),
                              prefixIcon: Icon(Iconsax.mobile),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'Phone Number', value), // Fixed property name
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.loading.value ? () {} : controller.updateUserInformation(),
                    child: controller.loading.value
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : const Text('Update Profile'),
                  )
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}

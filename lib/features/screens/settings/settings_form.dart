import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/setting_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App Settings",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwSection),

                // App Name
                TextFormField(
                  controller: controller.appNameController,
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text("App Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputField),

                // Tax Rate
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.taxController,
                        decoration: const InputDecoration(
                          hintText: 'Tax  %',
                          label: Text("Tax Rate (%)"),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                        child: TextFormField(
                          controller: controller.shippingController,
                            decoration: const InputDecoration(
                      hintText: 'Shipping Cost',
                      label: Text("Shipping Cost (\$)"),
                      prefixIcon: Icon(Iconsax.ship),
                    ))),

                      const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                        child: TextFormField(
                          controller: controller.freeShippingThresholdController,
                            decoration: const InputDecoration(
                      hintText: 'Free Shipping After (\$)',
                      label: Text("Free Shipping Threshold (\$)"),
                      prefixIcon: Icon(Iconsax.ship),
                    )))
                  ],
                ),
                      const SizedBox(width: TSizes.spaceBtwInputField * 2),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                      onPressed: () => controller.loading.value ? () {} : controller.updateSettingInformation(),
                      child: controller.loading.value ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2,) : const Text('Update App Settings'),)
                    ))
      ]),
            )
            )
              ],
            );
  }
        
  }


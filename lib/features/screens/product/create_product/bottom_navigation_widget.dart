import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/edit_product_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/sizes.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key, required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () {},
           child: const Text('Discard')),
          const SizedBox(width: TSizes.spaceBtwItem / 2),
          SizedBox(width: 160, 
          child: ElevatedButton(
            onPressed: () => EditProductController.instance.editProduct(product), 
            child: const Text('Save Changes'))),
        ],
      ),
    );
  }
}
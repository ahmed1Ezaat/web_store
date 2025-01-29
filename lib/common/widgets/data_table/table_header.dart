import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/device/device_utillity.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({
    super.key, this.onPressed, required this.buttonText, this.searchController, this.searchOnChanged,
  });

  final Function()? onPressed;
  final String buttonText;

  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
         Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: Row(
              children: [
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
                  ), // SizedBox
              ],
          ), // Row
      ), // Expanded
      Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
              controller: searchController,
              onChanged: searchOnChanged,
              decoration: const InputDecoration(hintText: 'Search here...', prefixIcon: Icon(Iconsax.search_normal)),
          ), // TextFormField
      ), // Expanded
            
      ],
    );
  }
}

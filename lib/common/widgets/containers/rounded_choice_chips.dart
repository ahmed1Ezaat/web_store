import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/circular_container.dart';

import '../../../controllers/helper_functions.dart';
import '../../../utils/constants/colors.dart';

class TChoiceChip extends StatelessWidget {
    // Create a chip that acts like a radio button.
    //
    // Parameters:
    //   text: The label text for the chip.
    //   selected: Whether the chip is currently selected.
    //   onSelected: Callback function when the chip is selected.
    const TChoiceChip({
        super.key,
        required this.text,
        required this.selected,
        this.onSelected,
    });

    final String text;
    final bool selected;
    final void Function(bool)? onSelected;

    @override
    Widget build(BuildContext context) {
        return Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: ChoiceChip(
                avatar: THelperFunctions.getColor(text) != null
                    ? TCircularContainer(width: 50, height: 50, backgroundColor: THelperFunctions.getColor(text)!)
                    : null,
                selected: selected,
                onSelected: onSelected,
                backgroundColor: THelperFunctions.getColor(text),
                labelStyle: TextStyle(color: TColors.white),
                shape: THelperFunctions.getColor(text) != null ? CircleBorder() : null,
                label: THelperFunctions.getColor(text) != null ? Text(text) : SizedBox(),
                padding: THelperFunctions.getColor(text) != null ? EdgeInsets.all(0) : null,
                labelPadding: THelperFunctions.getColor(text) != null ? EdgeInsets.all(0) : null,
            ),
        );
    }
}
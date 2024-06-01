import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../icons/t_circular_icon.dart';
class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: DSize.md,
          color: dark ? DColor.white : DColor.black,
          backgroundColor: dark ? DColor.darkerGrey : DColor.light,
        ),
        const SizedBox(
          width: DSize.spaceBtwItem,
        ),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: DSize.spaceBtwItem,
        ),
        TCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: DSize.md,
            color: dark ? DColor.white : DColor.black,
            backgroundColor: DColor.primary),
      ],
    );
  }
}

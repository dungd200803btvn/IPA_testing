import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';
class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DSize.defaultspace,vertical: DSize.defaultspace/2),
      decoration: BoxDecoration(
        color: dark? DColor.darkerGrey:DColor.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DSize.cardRadiusLg),
          topRight: Radius.circular(DSize.cardRadiusLg)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const TCircularIcon(icon: Iconsax.minus,
                backgroundColor: DColor.darkGrey,
                width: 40,
                height: 40,
                color: DColor.white,
              ),
              const SizedBox(width: DSize.spaceBtwItem),
              Text('2',style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: DSize.spaceBtwItem,),
              const TCircularIcon(icon: Iconsax.add,
                backgroundColor: DColor.black,
                width: 40,
                height: 40,
                color: DColor.white,
              ),
            ],

          ),
          ElevatedButton(onPressed: (){},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(DSize.md),
            backgroundColor: DColor.black,
            side: const BorderSide(color: DColor.black)
          ), child: const Text('Add to cart'),),


        ],
      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_branc_title_text_with_verified_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';
class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Price && Sale price
        Row(
          children: [
            //Sale Tag
            TRoundedContainer(
              radius: DSize.sm,
              backgroundColor: DColor.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: DSize.sm,vertical: DSize.xs),
              child: Text('25%',style: Theme.of(context).textTheme.labelLarge!.apply(color: DColor.black),),
            ),
            const SizedBox(width: DSize.spaceBtwItem),

            //Price
            Text('\$250',style: Theme.of(context).textTheme.titleSmall!.apply(decoration:TextDecoration.lineThrough)),
            const SizedBox(width: DSize.spaceBtwItem),
            const TProductPriceText(price: '175',isLarge: true),
            const SizedBox(height: DSize.spaceBtwItem/1.5),
          ],
        ),
        //Title
        const TProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(height: DSize.spaceBtwItem/1.5),
        //Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: DSize.spaceBtwItem),
            Text('In Stock',style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: DSize.spaceBtwItem/1.5),
        //Branch
        Row(
          children: [
            TCircularImage(image: TImages.cosmeticsIcon,width: 32,height: 32,overlayColor: dark? DColor.white:DColor.black),
            const TBrandTitleWithVerifiedIcon(title: 'Nike',branchTextSize: TTextSize.medium),
          ],
        ),
      ],
    );
  }
}

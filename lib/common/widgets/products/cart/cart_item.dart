import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_branc_title_text_with_verified_icon.dart';
class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        //Image
        TRoundedImage(imageUrl: TImages.productImage7,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(DSize.sm),
          backgroundColor: dark? DColor.darkerGrey:DColor.light,
        ),
        const SizedBox(width: DSize.spaceBtwItem,),
        //Title,Price,Size
        Expanded(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'Nike'),
              const Flexible(child: TProductTitleText(title: 'Black sport shoes',maxLines: 1,)),
              //Attributes
              Text.rich(TextSpan(
                  children: [
                    TextSpan(text: 'Color',style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Green',style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size',style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'UK-08',style: Theme.of(context).textTheme.bodyLarge),
                  ]
              ))
            ],
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //Selected attributes pricing and description
        TRoundedContainer(
          padding: const EdgeInsets.all(DSize.md),
          backgroundColor: dark ? DColor.darkerGrey : DColor.grey,
          child: Column(
            children: [
              //Title,price,stock
              Row(
                children: [
                  //Title
                  const TSectionHeading(title: 'Variation', showActionButton: false),
                  const SizedBox(width: DSize.spaceBtwItem),
                  //Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Price
                      Row(
                        children: [
                          const TProductTitleText(title: 'Price', smallSize: true),
                          //Actual price
                          Text('\$25',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough)),
                          //Sale price

                          const SizedBox(width: DSize.spaceBtwItem/2),
                          const TProductPriceText(price: '20')
                        ],
                      ),
                      //Stock
                      Row(
                        children: [
                          const TProductTitleText(title: 'Stock:',smallSize: true),
                          const SizedBox(width: DSize.spaceBtwItem/2),
                          Text('In Stock',style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),

                ],
              ),

              //Variation Description
              const TProductTitleText(title: 'This is the description of the product and it can go up to max 4 lines',
              smallSize: true,
              maxLines: 4),


            ],
          ),
        ),
        const SizedBox(height: DSize.spaceBtwItem),
        //Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors',showActionButton: false),
            const SizedBox(height: DSize.spaceBtwItem/2),
            Wrap(
              spacing: 8,
              children: [

                TChoiceChip(text: 'Blue', selected: false,onSelected: (value){},),
                TChoiceChip(text: 'Green', selected: true,onSelected: (value){},),
                TChoiceChip(text: 'Yellow', selected: false,onSelected: (value){},),
    ]

            )

          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size',showActionButton: false,),
            const SizedBox(height: DSize.spaceBtwItem/2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'EU 34', selected: false,onSelected: (value){},),
                TChoiceChip(text: 'EU 36', selected: true,onSelected: (value){},),
                TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){},),
              ],
            )

          ],
        ),


      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_branc_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/enum/enum.dart';

import '../../../../features/shop/controllers/product_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../../styles/shadows.dart';
class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});
final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = DHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DSize.productImageRadius),
          color: dark ? DColor.darkerGrey : DColor.softGrey,
          boxShadow: [TShadowStyle.verticalProductShadow]),
      child: Row(
        children: [
          //Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(DSize.sm),
            backgroundColor: dark? DColor.dark:DColor.light,
            child: Stack(
              children: [
                 SizedBox(
                    height: 120,
                width: 120,
                    child: TRoundedImage(imageUrl: product.thumbnail,applyImageRadius: true,isNetWorkImage: true,),),
                //Sale Tag
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: DSize.sm,
                    backgroundColor: DColor.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: DSize.sm, vertical: DSize.xs),
                    child: Text('$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: DColor.black)),
                  ),
                ),
                //Favourite Button
               Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: product.id ,)),
              ],
            ),
          ),
          const SizedBox(width: DSize.spaceBtwItem/2,),

          //Detail
          Expanded(
            child: SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: DSize.sm,left: DSize.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(title: product.title,smallSize: true,),
                        const SizedBox(height: DSize.spaceBtwItem/2,),
                        TBrandTitleWithVerifiedIcon(title: product.brand!.name)
                      ],
                    ),
                    const Spacer(),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Pricing
                         Flexible(child: Column(
                           children: [
                             if(product.productType == ProductType.single.toString() && product.salePrice>0)
                               Padding(padding: const EdgeInsets.only(left: DSize.sm),
                               child: Text(
                                 product.price.toString(),
                                 style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                               ),),
                             Padding(padding: const EdgeInsets.only(left: DSize.sm),child: TProductPriceText(price: controller.getProductPrice(product),),)
                           ],
                         )),
                        //Add to cart
                          Container(
                            decoration: const BoxDecoration(
                              color: DColor.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(DSize.cardRadiusMd),
                                bottomRight: Radius.circular(DSize.productImageRadius)
                              )
                            ),
                            child: const SizedBox(
                              width: DSize.iconLg*1.2,
                              height: DSize.iconLg*1.2,
                              child: Center(child: Icon(Iconsax.add,color: DColor.white,),),
                            ),
                          )
                      ],
                    )
            
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


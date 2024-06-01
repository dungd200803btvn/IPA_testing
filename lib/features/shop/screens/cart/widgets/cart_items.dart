import 'package:flutter/material.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key,
     this.showAddRemoveButtons = true
  });
final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => Column(
              children: [
                const TCartItem(),
                if(showAddRemoveButtons)const SizedBox(
                  height: DSize.spaceBtwItem,
                ),


                if(showAddRemoveButtons)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //Can le trai
                        SizedBox(
                          width: 70,
                        ),
                        //Add and remove button
                        TProductQuantityWithAddRemoveButton(),
                      ],
                    ),
                    TProductPriceText(price: '256'),
                  ],
                )
              ],
            ),
        separatorBuilder: (_, __) => const SizedBox(
              height: DSize.spaceBtwSection,
            ),
        itemCount: 2);
  }
}

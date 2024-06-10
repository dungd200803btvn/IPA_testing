import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) => Obx(() {
                final item = controller.cartItems[index];
                return Column(
                  children: [
                    TCartItem(
                      cartItem: item,
                    ),
                    if (showAddRemoveButtons)
                      const SizedBox(
                        height: DSize.spaceBtwItem,
                      ),
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              //Can le trai
                              SizedBox(
                                width: 70,
                              ),
                              //Add and remove button
                              TProductQuantityWithAddRemoveButton(
                                quantity: item.quantity,
                                add: () => controller.addOneToCart(item),
                                remove: () =>
                                    controller.removeOneFromCart(item),
                              ),
                            ],
                          ),
                          //Product total price
                           TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                        ],
                      )
                  ],
                );
              }),
          separatorBuilder: (_, __) => const SizedBox(
                height: DSize.spaceBtwSection,
              ),
          itemCount: controller.cartItems.length),
    );
  }
}

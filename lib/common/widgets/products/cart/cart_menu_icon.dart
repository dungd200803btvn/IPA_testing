import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/helper/helper_function.dart';
import '../../../../utils/constants/colors.dart';
class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
     this.iconColor, this.counterBgColor, this.counterTextColor,
  });
  final Color? iconColor,counterBgColor,counterTextColor;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final dark = DHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: ()=> Get.to(()=> const CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor?? (dark? DColor.white: DColor.black),
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: counterBgColor?? (dark? DColor.black: DColor.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
            ()=>Text(
                  controller.numOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: counterTextColor?? (dark? DColor.white: DColor.black), fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

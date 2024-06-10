import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/product_detail.dart';
import 'package:t_store/utils/enum/enum.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddtoCartButton extends StatelessWidget {
  const ProductCardAddtoCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return GestureDetector(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = controller.toCartModel(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(()=> ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =controller.getProductQuantityInCart(product.id);
        return Container(
          decoration:  BoxDecoration(
              color: productQuantityInCart>0 ? DColor.primary:DColor.dark,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(DSize.cardRadiusMd),
                  bottomRight: Radius.circular(DSize.productImageRadius))),
          child:  SizedBox(
              width: DSize.iconLg * 1.2,
              height: DSize.iconLg * 1.2,
              child: Center(child: productQuantityInCart>0 ? Text(productQuantityInCart.toString(),style: Theme.of(context).textTheme.bodyLarge!.apply(color: DColor.white),)
              : Icon(Iconsax.add, color: DColor.white)
             )),
        );
      }),
    );
  }
}

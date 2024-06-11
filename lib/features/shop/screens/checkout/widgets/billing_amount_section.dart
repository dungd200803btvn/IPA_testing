import 'package:flutter/material.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/pricing_calculator.dart';
class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        //SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal',style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$$subTotal',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        //Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee',style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${DPricingCalculator.caculateShippingCost(subTotal, 'US')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        //Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${DPricingCalculator.caculateTax(subTotal, 'US')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        ///Order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${DPricingCalculator.calculateTotalPrice(subTotal, 'US')}',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/pricing_calculator.dart';

import '../../../controllers/product/order_controller.dart';
class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final orderController = OrderController.instance;
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
            Obx(()=> Text('\$${orderController.fee.value.toStringAsFixed(2)}',style: Theme.of(context).textTheme.labelLarge,)) ,
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        // //Tax Fee
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,),
        //     Text('\$${DPricingCalculator.caculateTax(subTotal, 'US')}',style: Theme.of(context).textTheme.labelLarge,),
        //   ],
        // ),
        // const SizedBox(height: DSize.spaceBtwItem/2,),
        ///Order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,),
            Obx(()=> Text('\$${orderController.totalAmount.value.toStringAsFixed(2)}',style: Theme.of(context).textTheme.labelLarge,)) ,
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
      ],
    );
  }
}

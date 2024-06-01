import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Column(
              //Items in the cart
              children: [
                 const TCartItems(
                   showAddRemoveButtons: false,
                ),
                const SizedBox(
                  height: DSize.spaceBtwSection,
                ),
                //Coupon TextField
                const TCouponCode(),
                const SizedBox(
                  height: DSize.spaceBtwSection,
                ),
        
                //Billing Section
                TRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark?DColor.black:DColor.white,
                  padding: const EdgeInsets.all(DSize.defaultspace),
                  child: const Column(
                    children: [
                      //Pricing
                      TBillingAmountSection(),
                      SizedBox(height: DSize.spaceBtwItem,),
                      //Divider
                      Divider(),
                      SizedBox(height: DSize.spaceBtwItem,),
                      //Payment Method
                      TBillingPaymentSection(),
                  SizedBox(height: DSize.spaceBtwItem,),
                      //Address
                      TBillingAddressSection(),
                      SizedBox(height: DSize.spaceBtwItem,),
                    ],
                  ),
                )
        
              ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DSize.defaultspace),
        child: ElevatedButton (
          onPressed: ()=> Get.to(()=> SuccessScreen(image:TImages.successfulPaymentIcon,
              title: 'Payment Success',
              subTitle: 'Your item will be shipped soon!',
          onPressed: ()=> Get.offAll(()=> const NavigationMenu()),)),
          child: const Text('Checkout \$256.0'),

        ),
      ),

    );
  }
}


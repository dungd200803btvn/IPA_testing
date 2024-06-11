import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/payment_method_model.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(image: TImages.paypal, name: 'Paypal');
    super.onInit();
  }

  Future<dynamic>  selectPaymentMethod(BuildContext buildContext){
    return showModalBottomSheet(context: buildContext,
        builder: (_)=> SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(DSize.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSectionHeading(title: 'Select Payment Method',showActionButton: false,),
                SizedBox(height: DSize.spaceBtwSection,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal',image: TImages.paypal)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay',image: TImages.googlePay)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay',image: TImages.applePay)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA',image: TImages.visa)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card',image: TImages.masterCard)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm',image: TImages.paytm)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paystack',image: TImages.paystack)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card',image: TImages.creditCard)),
                SizedBox(height: DSize.spaceBtwItem/2,),
                SizedBox(height: DSize.spaceBtwSection,),
              ],
            ),
          ),

        ));
  }
}
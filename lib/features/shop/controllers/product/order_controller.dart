import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/order/order_repository.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //variables
  final cartController = Get.put(CartController());
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoader.warningSnackbar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());
      await orderRepository.saveOrder(order, userId);
      cartController.clearCart();
      Get.off(() => SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Payment Success',
            subTitle: 'Your item will be shipped soon!',
            onPressed: () => Get.offAll(() => NavigationMenu()),
          ));
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
}

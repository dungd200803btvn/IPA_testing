import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/order/order_repository.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

import '../../../../api/ApiService.dart';
import '../../../../data/model/OrderDetailResponseModel.dart';
import '../../../../data/model/OrderResponseModel.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../personalization/models/address_model.dart';
import '../../../suggestion/suggestion_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  var fee = 0.0.obs; // Biến quan sát được để lưu giá trị totalFee
  var totalAmount = 0.0.obs; // Biến quan sát được để lưu giá trị totalFee
  //variables
  final cartController = Get.put(CartController());
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final userController = UserController.instance;
  final orderRepository = Get.put(OrderRepository());
  final suggestionRepository = Get.put(ProductSuggestionRepository());
  ShippingOrderModel? shippingOrder;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      await suggestionRepository.generateAndSaveSuggestions(userOrders);
      const productId = "002";
      final suggestion = await suggestionRepository.getProductSuggestions(productId);
      if (kDebugMode) {
        print('Suggested products for $productId: ${suggestion.suggestedProducts}');
      }
      await suggestionRepository.getSortedSuggestions(productId);
      return userOrders;
    } catch (e) {
      TLoader.warningSnackbar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Hàm tính phí và tổng phí
  Future<void> calculateFeeAndTotal(double subTotal) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;
      // Fetch current user details
      final userDetails = await userController.fetchCurrentUserDetails(userId);
      final selectedAddress = addressController.selectedAddress.value;
      if (kDebugMode) {
        print('selectedAddress: ${selectedAddress.toJson()}');
      }
      // Nếu không có địa chỉ được chọn, thông báo lỗi và dừng tiến trình
      if (selectedAddress == AddressModel.empty()) {
        TLoader.errorSnackbar(title: 'Error', message: 'No address selected');
        return;
      }

      final items = cartController.cartItems.map((item) {
        return {
          "name": item.title,
          "code": item.productId,
          "quantity": item.quantity,
          "price": item.price.toInt(),
          "length": 100,
          "width": 100,
          "weight": 5000,
          "height": 100,// Thêm giá trị mặc định hoặc tính toán từ sản phẩm
          "category": {"level1": "Áo"}
        };
      }).toList();
      final shippingData = {
        "payment_type_id": 2,
        "service_type_id": 2,
        "note": "Order note here",
        "required_note": "CHOXEMHANGKHONGTHU",
        "from_name": "TinTest124",
        "from_phone": "0987654321",
        "from_address": "72 Thành Thái, Phường 14, Quận 10, Hồ Chí Minh, Vietnam",
        "from_ward_name": "Phường 14",
        "from_district_name": "Quận 10",
        "from_province_name": "HCM",
        "to_name": "${userDetails.firstName} ${userDetails.lastName}",
        "to_phone": selectedAddress.phoneNumber,
        "to_address": selectedAddress.toString(),
        "to_ward_name": selectedAddress.commune,
        "to_district_name": selectedAddress.district,
        "to_province_name": selectedAddress.city,
        "weight": 1200,
        "cod_amount": 15000,
        "content": "Đơn hàng thời trang",
        "items": items
      };

      final shippingService = ShippingOrderService();
      final response = await shippingService.createShippingOrder(shippingData);
      shippingOrder = ShippingOrderModel.fromJson(response);
      if (kDebugMode) {
        print('Order Code: ${shippingOrder?.orderCode}');
        print('Total Fee: ${shippingOrder?.totalFee}');
        print('Main Service Fee: ${shippingOrder?.fee.mainService}');
        print('Expected Delivery Time: ${shippingOrder?.expectedDeliveryTime}');
        print('Message: ${shippingOrder?.messageDisplay}');
      }
      if(shippingOrder!=null){
        fee.value = shippingOrder!.totalFee.toDouble()/24500.0;//doi sang USD
      }
      totalAmount.value = subTotal + fee.value;
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }

  //add methods for order processing
  void processOrder(double subTotal) async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);
      ShippingOrderService shippingService  =  ShippingOrderService();
      try {
        if (kDebugMode) {
          final detailOrder = await shippingService.getOrderDetail(shippingOrder!.orderCode);
          final shippingDetailOrder = OrderDetailModel.fromJson(detailOrder);
          print('shippingDetailOrder: ${shippingDetailOrder.toJson()}');
          DateTime deliveryTime = DateTime.parse(shippingOrder!.expectedDeliveryTime).toLocal();
          final userId = AuthenticationRepository.instance.authUser!.uid;
          final order = OrderModel(
              id: shippingOrder!.orderCode,
              userId: userId,
              status: OrderStatus.pending,
              totalAmount: totalAmount.value,
              orderDate: DateTime.now(),
              paymentMethod: checkoutController.selectedPaymentMethod.value.name,
              address: addressController.selectedAddress.value,
              deliveryDate: deliveryTime,
              items: cartController.cartItems.toList(),
              orderDetail: shippingDetailOrder);
          await orderRepository.saveOrder(order, userId);
          // gen suggest từ đơn hàng mới
          final userOrders = await orderRepository.fetchUserOrders();
          await suggestionRepository.generateAndSaveSuggestions(userOrders);
          cartController.clearCart();
          Get.off(() => SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Payment Success',
            subTitle: 'Your item will be shipped soon!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to create order: $e');
        }
      }
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }

}



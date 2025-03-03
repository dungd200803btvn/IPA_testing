import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/images_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';
import '../../../../l10n/app_localizations.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = "".obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  late AppLocalizations lang;
  @override
  void onReady() {
    super.onReady();
    // Bây giờ Get.context đã có giá trị hợp lệ, ta mới khởi tạo lang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      lang = AppLocalizations.of(Get.context!);
    });
  }
  ///select attributes and variations
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;
    final selectedVariation = product.productVariations!.firstWhere(
        (element) =>
            _isSameAttributeValues(element.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());
    //set main image to selected variation image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }
    //show selected variation quantity already in cart
    if(selectedVariation.id.isNotEmpty){
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }
    //assign selected variation
    this.selectedVariation.value = selectedVariation;
  }

  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) {
      return false;
    }
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

//check attributes availability/stock in variation
  Set<String?> getAttributesAvailabilityVariation(
      List<ProductVariationModel> variations, String attributeName) {
    return variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();
  }

  String getVariationPrice([double? salePercentage]){
    return (salePercentage!=null ? selectedVariation.value.price*(1-salePercentage):selectedVariation.value.price ).toStringAsFixed(1);
  }
  //check status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? lang.translate('in_stock') : lang.translate('out_stock');
  }

  //reset
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}

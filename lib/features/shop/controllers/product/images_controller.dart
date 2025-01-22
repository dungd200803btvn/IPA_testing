import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  //variables
  RxString selectedProductImage = ''.obs;
// List of all product images
  late RxList<String> images = <String>[].obs;
  //get all images from product and variations
  // List<String> getAllProductImages(ProductModel productModel) {
  //   Set<String> images = {};
  //
  //   // Tải hình ảnh thu nhỏ (không có bản sao ở đây)
  //   // images.add(productModel.thumbnail);
  //    selectedProductImage.value = productModel.thumbnail;
  //
  //   // Thêm hình ảnh duy nhất từ productModel.images
  //   if (productModel.images != null) {
  //     images.addAll(productModel.images!.where((image) => !images.contains(image)));
  //
  //   }
  //
  //   // Thêm hình ảnh duy nhất từ product variations
  //   // if (productModel.productVariations != null &&
  //   //     productModel.productVariations!.isNotEmpty) {
  //   //   images.addAll(productModel.productVariations!.map((e) => e.image).where((image) => !images.contains(image)));
  //   // }
  //
  //   return images.toList();
  // }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  // Initialize the controller with product data
  void initialize(ProductModel productModel) {
    // Reset the selected image and image list
    selectedProductImage.value = productModel.thumbnail;
    images.clear();

    // Add thumbnail and other unique images
    Set<String> uniqueImages = {productModel.thumbnail};
    if (productModel.images != null) {
      uniqueImages.addAll(productModel.images!);
    }
    images.addAll(uniqueImages);
  }


//show image popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: DSize.defaultspace*2,horizontal: DSize.defaultspace),
                child: CachedNetworkImage(imageUrl: image,),),
                const SizedBox(height: DSize.spaceBtwSection,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    child: OutlinedButton(onPressed: ()=> Get.back(),child: const Text("Close"),),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

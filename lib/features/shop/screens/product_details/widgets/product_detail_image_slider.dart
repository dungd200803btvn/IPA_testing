import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:t_store/features/shop/controllers/product/images_controller.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_function.dart';
import '../../../models/product_model.dart';
class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,

  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    // Gọi initialize sau khi build hoàn thành
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(product);
    });
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? DColor.darkerGrey : DColor.light,
        child: Stack(
          children: [
            //1.1 Main Larger Image
             SizedBox(
              height: 400,
              child: Padding(
                padding:
                const EdgeInsets.all(DSize.productImageRadius * 2),
                child: Center(
                    child: Obx(() {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: ()=> controller.showEnlargedImage(image),
                        child: CachedNetworkImage(imageUrl: image,
                        progressIndicatorBuilder: (_,__,downloadProgress)=>
                            CircularProgressIndicator(value: downloadProgress.progress,color: DColor.primary,),),
                      );
                    })),
              ),
            ),

            //1.2 Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: DSize.defaultspace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => Obx(
                    (){
                      final images = controller.images;
                      if (index < 0 || index >= images.length) {
                        return const SizedBox.shrink(); // Widget trống nếu index không hợp lệ
                      }
                      final imageSelected = controller.selectedProductImage.value == images[index];
                      return TRoundedImage(
                        isNetWorkImage: true,
                        // onPressed: ()=> controller.selectedProductImage.value = images[index],
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.selectedProductImage.value = images[index];
                          });
                        },
                        imageUrl: images[index],
                        width: 80,
                        backgroundColor: dark ? DColor.dark : DColor.white,
                        border: Border.all(      color: imageSelected? DColor.primary:   Colors.transparent),
                        padding: const EdgeInsets.all(DSize.sm),
                      );
                    }
                  ),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: DSize.spaceBtwItem),
                  itemCount: controller.images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
            //1.3 Appbar Icon
            TAppBar(
              showBackArrow: true,
              actions: [
                TFavouriteIcon(productId: product.id,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
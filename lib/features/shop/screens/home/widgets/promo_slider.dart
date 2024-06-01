import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/shimmer/shimmer.dart';
import 'package:t_store/features/shop/controllers/banner_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      //loading
      if (controller.isLoading.value) return TShimmerEffect(width: double.infinity, height: 190);
      //no data found
      if (controller.banners.isEmpty) {
        return Center(child: Text('No data found'),);
      } else {
        return Column(

          children: [
         CarouselSlider(
        items: controller.banners.map((banner) {
          return TRoundedImage(
            imageUrl: banner.imageUrl,
            isNetWorkImage: true,
            onPressed: () => Get.toNamed(banner.targetScreen),
            // Use preloaded imageProvider if available
          );
        }).toList(),
              options: CarouselOptions(
                height: 220, // Set a fixed height for the carousel
                viewportFraction: 0.9,
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
                autoPlay: true, // Enable autoplay
                autoPlayInterval: const Duration(seconds: 2), // Set autoplay interval
              ),
            ),
            const SizedBox(height: DSize.spaceBtwItem),
            Center(
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < min(4, controller.banners.length); i++)
                      TCircularContainer(
                        width: 4,
                        height: 4,
                        backgroundColor: controller.carousalCurrentIndex.value == i
                            ? DColor.primary
                            : DColor.grey,
                        margin: const EdgeInsets.only(right: 10),
                      ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    });
  }
}

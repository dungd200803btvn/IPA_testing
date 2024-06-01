import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_review.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';

import '../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return  Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //1. PRODUCT IMAGE SLIDER
            const TProductImageSlider(),
            //2. PRODUCT DETAIL
            Padding(padding: const EdgeInsets.only(right: DSize.defaultspace,left: DSize.defaultspace,bottom: DSize.defaultspace),
            child: Column(
              children: [
                //2.1 Rating && Share
                const TRatingAndShare(),
                //2.2 Price,Title,Stock,Branch
                const TProductMetaData(),
                //2.3 Attributes
                const ProductAttributes(),
                const SizedBox(height: DSize.spaceBtwSection),
                //2.4 Checkout Button

                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){},child: const Text('Checkout'),),),
                const SizedBox(height: DSize.spaceBtwSection),
                //2.5 Description
                const TSectionHeading(title: 'Description',showActionButton: false),
                const SizedBox(height: DSize.spaceBtwItem),
                const ReadMoreText(
                    "Elevate your runs (or your everyday look) with the latest Nike shoes. Nike offers unparalleled cushioning and responsiveness thanks to innovative technologies like React foam or Zoom Air.  The breathable mesh uppers keep your feet cool, while the secure lacing system provides a locked-in feel. Whether you're a serious athlete or just seeking a stylish and comfortable shoe, Nike has the perfect pair to help you conquer your day.",
                  trimLines: 2,//so dong toi da
                  trimMode: TrimMode.Line,//giu nguyen cac tu va tu ngat neu vuot qua 2 dong
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Less',
                  moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                  lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),

            ),
                //2.6 Review
                const Divider(),
                const SizedBox(height: DSize.spaceBtwItem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TSectionHeading(title: 'Review(199)',onPressed: (){},showActionButton: false,),
                    IconButton(onPressed: ()=> Get.to(()=> const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3))
                  ],
                ),
                const SizedBox(height: DSize.spaceBtwSection)
              ],
            ),)
          ],
        ),
      ),
    );
  }
}





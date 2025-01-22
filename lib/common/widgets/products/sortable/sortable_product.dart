import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/all_products_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
    this.applyDiscount = false
  });
 final List<ProductModel> products;
 final bool applyDiscount;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    // Di chuyển logic cập nhật trạng thái ra ngoài build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.assignProducts(products);
    });
    return Column(
      children: [
        //Drop down
        DropdownButtonFormField(
          items: ['Name','Higher Price','Lower Price','Sale','Newest','Popularity'].map((option) => DropdownMenuItem(value:option,child:  Text(option))).toList(),
          value: controller.selectedSortOption.value,
          onChanged: (value){
            controller.sortProducts(value!);
          },
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),),
        const SizedBox(height: DSize.spaceBtwSection,),
        /// Products
        Obx((){
          final discounts  = applyDiscount? calculateDiscounts(products.length): [];
          return TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_,index)=> TProductCardVertical(product: controller.products[index],salePercentage: applyDiscount? discounts[index]/100.0: null,));

    } ),
      ],
    );
  }

  // Tính toán giảm giá nếu cần
  List<double> calculateDiscounts(int count) {
    List<double> discounts = [];
    double discount = 30.0;
    for (int i = 0; i < count; i++) {
      if (discount > 10.0) {
        discounts.add(discount);
        discount -= 2.0;
      } else {
        discounts.add(10.0);
      }
    }
    return discounts;
  }
}
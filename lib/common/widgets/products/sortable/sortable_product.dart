import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';
class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Drop down
        DropdownButtonFormField(
          items: ['Name','Higher Price','Lower Price','Sale','Newest','Popularity'].map((option) => DropdownMenuItem(value:option,child:  Text(option))).toList(),
          onChanged: (value){},
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),),
        const SizedBox(height: DSize.spaceBtwSection,),
        /// Products
        TGridLayout(itemCount: 12, itemBuilder: (_,index)=> TProductCardVertical(product: ProductModel.empty() ,))
      ],
    );
  }
}
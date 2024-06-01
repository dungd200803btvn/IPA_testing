import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/t_brand_cart.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/brand/brand_products.dart';
import 'package:t_store/utils/constants/sizes.dart';
class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Column(
            children: [
              //Heading
              const TSectionHeading(title: 'Brand',showActionButton: false,),
              const SizedBox(height: DSize.spaceBtwItem,),
              //Brands
              TGridLayout(itemCount: 10,
                itemBuilder: (context,index)=>  TBrandCard(showBorder: true,onTap: ()=> Get.to(()=>const BrandProducts()),),
                mainAxisExtent: 80,)
            ],
          ),
        ),
      ),
    );
  }
}

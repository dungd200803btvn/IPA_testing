import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/t_brand_cart.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/utils/constants/sizes.dart';
class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Nike'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DSize.defaultspace),
          child: Column(
            children: [
              //Brand Detail
              TBrandCard(showBorder: true),
              SizedBox(height: DSize.spaceBtwSection,),
              TSortableProducts(products: [],)
            ],
          ),
        ),
      ),
    );
  }
}

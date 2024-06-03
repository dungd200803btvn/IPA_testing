import 'package:get/get.dart';
import 'package:t_store/data/dummy_data.dart';
import 'package:t_store/data/repositories/brands/brand_repository.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/popups/loader.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();
  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository  = Get.put(BrandRepository());
  @override
  void onInit() {
    //brandRepository.uploadDummyData(TDummyData.brands);
    getFeaturedBrands();
    super.onInit();
  }
  Future<void> getFeaturedBrands() async{
    try{
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured?? false).take(4));
    }catch(e){
      TLoader.errorSnackbar(title: 'Oh Snap!',message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  //get products of a brand
Future<List<ProductModel>> getBrandProducts(String brandId) async{
    try{
      final products = await ProductRepository.instance.getProductsForBrand( brandId: brandId);
      return products;
    }
    catch(e){
      TLoader.errorSnackbar(title: 'Oh Snap!',message: e.toString());
      return [];
    }

}


}
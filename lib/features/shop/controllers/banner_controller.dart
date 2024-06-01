import 'package:get/get.dart';
import 'package:t_store/data/dummy_data.dart';
import 'package:t_store/data/repositories/banners/banner_repository.dart';
import 'package:t_store/features/shop/models/banner_model.dart';
import '../../../utils/popups/loader.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();
  //variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  final bannerRepo = Get.put(BannerRepository());
  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }
  //update page navigation dots
  void updatePageIndicator(index){
    carousalCurrentIndex.value  = index;
  }
  //bannerRepo.uploadDummyData(TDummyData.banners);
  //fetch banners
  Future<void> fetchBanners() async{
    try{
      isLoading.value = true;
      //fetch
      final banners = await bannerRepo.fetchBanners();
      this.banners.assignAll(banners);
    }catch(e){
      TLoader.errorSnackbar(title: 'Oh Snap',message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

}
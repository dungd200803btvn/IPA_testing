import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/popups/loader.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final query = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Đăng ký lắng nghe thay đổi từ TextEditingController
    query.addListener(_searchProducts);
    loadAllProducts();
  }

  final productRepository = Get.put(ProductRepository());
  final RxList<ProductModel> _allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  // Phương thức để tải tất cả sản phẩm từ Firestore và lưu trữ trong biến cục bộ
  Future<void> loadAllProducts() async {
    try {
      _allProducts.value = await productRepository.getAllProducts();
      // Khởi tạo danh sách lọc bằng tất cả sản phẩm
      filteredProducts.value = _allProducts.value;
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Phương thức để tìm kiếm sản phẩm theo query
  void _searchProducts() {
    String lowerCaseQuery = query.text.toLowerCase();
    filteredProducts.value = _allProducts.where((product) =>
        product.title.toLowerCase().contains(lowerCaseQuery)).toList();
  }

  @override
  void onClose() {
    query.removeListener(_searchProducts);
    super.onClose();
  }
}


// List<ProductModel> getProductsBySearchQuery(String query) {
//   try {
//     String lowerCaseQuery = query.toLowerCase();
//     return _allProducts.value.where((product) =>
//         product.title.toLowerCase().contains(lowerCaseQuery)).toList();
//   } catch (e) {
//     TLoader.errorSnackbar(title: 'Oh Snap!', message: e.toString());
//     return [];
//   }
// }
//
// Future<List<ProductModel>> getProductsBySearchQuery1(String query) async {
//   try {
//     return await productRepository.getProductsBySearchQuery(query);
//   } catch (e) {
//     TLoader.errorSnackbar(title: 'Oh Snap!', message: e.toString());
//     return [];
//   }
// }
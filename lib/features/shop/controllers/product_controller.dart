import 'dart:math';

import 'package:get/get.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/product_attribute_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/enum/enum.dart';
import '../../../utils/popups/loader.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../models/brand_model.dart';
import '../models/product_variation_model.dart';
class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      //fetch products
      final products = await productRepository.getFeaturedProducts();
      final products1 = await productRepository.getAllProducts();
      //assign products
      featuredProducts.assignAll(products);
      allProducts.assignAll(products1);
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap', message: e.toString());
      print("error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async{
     try{
      return await productRepository.getAllProducts();
    }catch(e){
     TLoader.errorSnackbar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    //if no variations exist, return simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      //calculate max and min price
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        //update min max
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    }
    if (originalPrice <= 0.0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out Stock';
  }



  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
  int generateRandomId() {
    final random = Random();
    return 100 + random.nextInt(901); // Từ 100 đến 1000
  }
  double generatePrice(){
    return 10+ Random().nextDouble()*1000;
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    return list[random.nextInt(list.length)];
  }


  Future<List<ProductModel>> readProductsFromJson(String filePath) async {
    // Đọc dữ liệu từ file JSON
    final jsonString = await getFileData(filePath);
    final List<dynamic> jsonResponse = json.decode(jsonString);

    // Giới hạn số lượng đối tượng đọc từ JSON
    final limitedJsonResponse = jsonResponse.take(200).toList();

    // Danh sách các màu
    List<String> colors = ['Green', 'Black', 'Red', 'Blue', 'Yellow'];

    // Chuyển đổi JSON thành danh sách các đối tượng ProductModel
    return limitedJsonResponse.map((product) {
    List<String> images =   product['image_urls'] != null ? List<String>.from(product['image_urls']) : [];
    List<String> defaultSizes = ['EU 30','EU 32','EU 34','EU 36','EU 38'];


      // Tạo danh sách các giá trị cho thuộc tính 'Size'
      List<String> availableSizes = product['available_sizes'] != null ? List<String>.from(product['available_sizes'].length>=5 ? product['available_sizes'].map((size) => 'EU $size' as String): defaultSizes) : defaultSizes;

      // Tạo đối tượng ProductAttributeModel cho 'Size'
      ProductAttributeModel sizeAttribute = ProductAttributeModel(name: 'Size', values: availableSizes);

      // Tạo đối tượng ProductAttributeModel cho 'Color'
      ProductAttributeModel colorAttribute = ProductAttributeModel(name: 'Color', values: colors);

      // Tạo danh sách các biến thể sản phẩm với màu và size tương ứng
      List<ProductVariationModel> productVariations = [];
      if (product['variants'] != null) {
        for (String color in colors) {
          for (String size in availableSizes) {
            String sku = product['sku'] ;  // Thay bằng logic sinh SKU của bạn
            productVariations.add(ProductVariationModel(
              id: sku,
              stock: generateRandomId(), // Assuming `in_stock` is a boolean
              price: generatePrice().roundToDouble(), // Giá trị mặc định, bạn có thể thay đổi theo yêu cầu
              salePrice: (generatePrice() * 0.85).roundToDouble(), // Giá trị mặc định, bạn có thể thay đổi theo yêu cầu
              image: images[0] , // Assuming `image` field exists
              description: 'The product has good quality and reasonable price, it is worth trying once', // Mô tả mặc định, bạn có thể thay đổi theo yêu cầu
              attributeValues: {'Color': color, 'Size': size},
            ));
          }
        }
      }
    double price  = generatePrice().roundToDouble();
      return ProductModel(
        id: product['objectID'] ?? '',
        stock: generateRandomId(),
        sku: product['sku'] ?? '',
        price:  price ,
        title: product['name'] ?? '',
        date: product['created_at'] != null ? DateTime.fromMillisecondsSinceEpoch(product['created_at']) : null,
        salePrice: (price*0.7).roundToDouble() ,
        thumbnail: product['image_urls'] != null && product['image_urls'].isNotEmpty ? product['image_urls'][0] : '',
        isFeatured: true, // Assuming this is not provided in your JSON
        brand: product['brand'] != null ? BrandModel(name: product['brand'], id:(1+ Random().nextInt(14)).toString(), image: images[0],isFeatured: true,productsCount: generateRandomId()) : null,
        description: 'The product has good quality and reasonable price, it is worth trying once',
        categoryId:  (1+ Random().nextInt(16)).toString(),
        images: product['image_urls'] != null ? List<String>.from(product['image_urls']) : [],
        productType: ProductType.variable.toString(),
        productAttributes: [sizeAttribute, colorAttribute],
        productVariations: productVariations,
      );
    }).toList();
  }

}


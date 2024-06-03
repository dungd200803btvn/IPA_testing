import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/enum/enum.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  //get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection("Products").where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: " + e.toString();
    }
  }
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products")
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: " + e.toString();
    }
  }
  //upload to cloud
  Future<void> uploadDummyData(List<ProductModel> products) async {
    final storage = Get.put(TFirebaseStorageService());
    for (var product in products) {
      final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
      final url = await storage.uploadImageData(
          'Products/Images', thumbnail, product.thumbnail.toString());
      product.thumbnail = url;
      //product list of images
      if (product.images != null && product.images!.isNotEmpty) {
        List<String> imagesUrl = [];
        for (var image in product.images!) {
          //get image data link from local assets
          final assetImage = await storage.getImageDataFromAssets(image);
          //upload image and get its url
          final url = await storage.uploadImageData(
              'Products/Images', assetImage, image);
          imagesUrl.add(url);
        }
        product.images!.clear();
        product.images!.addAll(imagesUrl);
      }
      //upload variation images
      if (product.productType == ProductType.variable.toString()) {
        for (var variation in product.productVariations!) {
          //get image data from local
          final assetImage =
              await storage.getImageDataFromAssets(variation.image);
          //upload image
          final url = await storage.uploadImageData(
              'Products/Images', assetImage, variation.image);
          variation.image = url;
        }
      }
      // Lưu dữ liệu cập nhật
      await _db.collection('Products').doc(product.id).set(product
          .toJson()); // Gọi phương thức toJson để chuyển đổi product thành JSON
    }
  }
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async{
    try{
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    }on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: " + e.toString();
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId,int limit=-1}) async{
    try{
      final querySnapshot = limit ==-1 ? await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).get():
      await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).limit(limit).get();
      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    }on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: " + e.toString();
    }
  }
}

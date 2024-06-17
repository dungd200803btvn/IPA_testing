import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_category_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/enum/enum.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  //get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    // try {
      final snapshot = await _db
          .collection("Products").limit(20)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    // } on FirebaseException catch (e) {
    //   throw e.message!;
    // } on PlatformException catch (e) {
    //   throw e.message!;
    // } catch (e) {
    //   throw "message: $e";
    // }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
    }
  }

  Future<List<ProductModel>> getProductsBySearchQuery(String query) async {
    try {
      // Lấy tất cả các sản phẩm từ Firestore
      final snapshot = await _db.collection("Products").get();

      // Chuyển query về chữ thường
      String lowerCaseQuery = query.toLowerCase();

      // Lọc các sản phẩm mà Title chứa query
      List<ProductModel> filteredProducts = snapshot.docs
          .map((e) => ProductModel.fromSnapshot(e))
          .where((product) => product.title.toLowerCase().contains(lowerCaseQuery))
          .toList();

      return filteredProducts;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
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

  Future<void> deleteDocumentsExceptRange(String collectionName, String startId, String endId) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection(collectionName);

    // Truy xuất tất cả các document trong collection
    QuerySnapshot snapshot = await collectionRef.get();

    // Lặp qua từng document và kiểm tra xem ID của nó có nằm trong phạm vi cần giữ lại hay không
    for (DocumentSnapshot doc in snapshot.docs) {
      String docId = doc.id;

      // Kiểm tra xem ID của document có nằm trong phạm vi từ startId đến endId hay không
      if (docId.compareTo(startId) < 0 || docId.compareTo(endId) > 0) {
        // Nếu không nằm trong phạm vi, xóa document này
        await collectionRef.doc(docId).delete().catchError((error) {
          print("Failed to delete document: $error");
        });
      }
    }
  }

  Future<void> uploadDummyData1(List<ProductModel> products) async {
    final storage = Get.put(TFirebaseStorageService());
    for (var product in products) {
      // Kiểm tra nếu thumbnail là URL hay không và không rỗng
      if (product.thumbnail.isNotEmpty && product.thumbnail.startsWith('http')) {
        // Nếu là URL và không rỗng, không làm gì
      } else if (product.thumbnail.isNotEmpty) {
        // Nếu không phải URL và không rỗng, tải từ tài sản cục bộ và upload
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());
        product.thumbnail = url;
      }

      // product list of images
      if (product.images != null && product.images!.isNotEmpty) {
        List<String> imagesUrl = [];
        for (var image in product.images!) {
          // Kiểm tra nếu image là URL hay không và không rỗng
          if (image.isNotEmpty && image.startsWith('http')) {
            // Nếu là URL và không rỗng, thêm vào danh sách URL
            imagesUrl.add(image);
          } else if (image.isNotEmpty) {
            // Nếu không phải URL và không rỗng, tải từ tài sản cục bộ và upload
            final assetImage = await storage.getImageDataFromAssets(image);
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);
            imagesUrl.add(url);
          }
        }
        product.images!.clear();
        product.images!.addAll(imagesUrl);
      }

      // upload variation images
      if (product.productType == ProductType.variable.toString()) {
        for (var variation in product.productVariations!) {
          // Kiểm tra nếu variation image là URL hay không và không rỗng
          // if (variation.image.isNotEmpty && variation.image.startsWith('http')) {
          //
          //   // Nếu là URL và không rỗng, không làm gì
          // } else if (variation.image.isNotEmpty) {
          //   // Nếu không phải URL và không rỗng, tải từ tài sản cục bộ và upload
          //   final assetImage = await storage.getImageDataFromAssets(variation.image);
          //   final url = await storage.uploadImageData(
          //       'Products/Images', assetImage, variation.image);
          //   variation.image = url;
          // }
        }
      }

      // Lưu dữ liệu cập nhật
      await _db.collection('Products').doc(product.id).set(product.toJson()); // Gọi phương thức toJson để chuyển đổi product thành JSON
    }
  }




  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection("Products").where(FieldPath.documentId,whereIn: productIds).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw "message: $e";
    }
  }
  Future<List<ProductModel>> getProductsForCategory1({required String categoryId}) async {
    // Lấy tất cả các sản phẩm từ Firestore
    final snapshot = await _db.collection('Products').get();

    // Lọc cục bộ các sản phẩm theo CategoryId đã chuyển thành chuỗi
    final products = snapshot.docs.map((doc) {
      final data = doc.data()!;
      final productCategoryId = data['CategoryId'].toString(); // Chuyển CategoryId sang chuỗi
      if (productCategoryId == categoryId) {
        return ProductModel.fromSnapshot(doc);
      } else {
        return null;
      }
    }).where((product) => product != null).toList().cast<ProductModel>();

    return products;
  }


  Future<void> uploadProductCategoryData(List<ProductCategoryModel> productcategory) async {
    for (var v in productcategory) {
      await _db
          .collection('ProductCategory')
          .add(v.toJson());
    }
  }

  Future<void> updateProducts() async {
    // Create a query to find products with 'bag' in the title
    QuerySnapshot querySnapshot = await _db
        .collection('Products')
        .get();

    // Loop through the query results and update each document
    for (var doc in querySnapshot.docs) {

      if (doc['Title'].toString().toLowerCase().contains('wallet')) {
        await doc.reference.update({'CategoryId': "24"});
      }
      if (doc['Title'].toString().toLowerCase().contains('belt')) {
        await doc.reference.update({'CategoryId': "31"});
      }
      if (doc['Title'].toString().toLowerCase().contains('jacket')) {
        await doc.reference.update({'CategoryId': "17"});
      }if (doc['Title'].toString().toLowerCase().contains('vest')) {
        await doc.reference.update({'CategoryId': "20"});
      }if (doc['Title'].toString().toLowerCase().contains('dress')) {
        await doc.reference.update({'CategoryId': "19"});
      }if (doc['Title'].toString().toLowerCase().contains('flip')) {
        await doc.reference.update({'CategoryId': "23"});
      }if (doc['Title'].toString().toLowerCase().contains('foulard')) {
        await doc.reference.update({'CategoryId': "21"});
      }if (doc['Title'].toString().toLowerCase().contains('hat')) {
        await doc.reference.update({'CategoryId': "22"});
      }if (doc['Title'].toString().toLowerCase().contains('sneaker')) {
        await doc.reference.update({'CategoryId': "32"});
      }if (doc['Title'].toString().toLowerCase().contains('shoes')) {
        await doc.reference.update({'CategoryId': "32"});
      }if (doc['Title'].toString().toLowerCase().contains('nike air jordan')) {
        await doc.reference.update({'CategoryId': "32"});
      }if (doc['Title'].toString().toLowerCase().contains('phone')) {
        await doc.reference.update({'CategoryId': "15"});
      }if (doc['Title'].toString().toLowerCase().contains('polo')) {
        await doc.reference.update({'CategoryId': "16"});
      }if (doc['Title'].toString().toLowerCase().contains('scarf')) {
        await doc.reference.update({'CategoryId': "21"});
      }if (doc['Title'].toString().toLowerCase().contains('shirt')) {
        await doc.reference.update({'CategoryId': "16"});
      }if (doc['Title'].toString().toLowerCase().contains('skirt')) {
        await doc.reference.update({'CategoryId': "19"});
      }if (doc['Title'].toString().toLowerCase().contains('snood altea')) {
        await doc.reference.update({'CategoryId': "21"});
      }if (doc['Title'].toString().toLowerCase().contains('socks')) {
        await doc.reference.update({'CategoryId': "27"});
      }if (doc['Title'].toString().toLowerCase().contains('suit')) {
        await doc.reference.update({'CategoryId': "29"});
      }if (doc['Title'].toString().toLowerCase().contains('sweater')) {
        await doc.reference.update({'CategoryId': "28"});
      }if (doc['Title'].toString().toLowerCase().contains('top better rich')) {
        await doc.reference.update({'CategoryId': "16"});
      }if (doc['Title'].toString().toLowerCase().contains('usb')) {
        await doc.reference.update({'CategoryId': "15"});
      }if (doc['Title'].toString().toLowerCase().contains('sandal')) {
        await doc.reference.update({'CategoryId': "26"});
      }if (doc['Title'].toString().toLowerCase().contains('ballerina')) {
        await doc.reference.update({'CategoryId': "32"});
      }if (doc['Title'].toString().toLowerCase().contains('bicycle')) {
        await doc.reference.update({'CategoryId': "1"});
      }if (doc['Title'].toString().toLowerCase().contains('amico')) {
        await doc.reference.update({'CategoryId': "33"});
      }if (doc['Title'].toString().toLowerCase().contains('cardigan')) {
        await doc.reference.update({'CategoryId': "28"});
      }if (doc['Title'].toString().toLowerCase().contains('chino')) {
        await doc.reference.update({'CategoryId': "18"});
      }if (doc['Title'].toString().toLowerCase().contains('clutch moschino love')) {
        await doc.reference.update({'CategoryId': "24"});
      }if (doc['Title'].toString().toLowerCase().contains('coat pinko multi')) {
        await doc.reference.update({'CategoryId': "19"});
      }if (doc['Title'].toString().toLowerCase().contains('jeans')) {
        await doc.reference.update({'CategoryId': "18"});
      }if (doc['Title'].toString().toLowerCase().contains('blazer')) {
        await doc.reference.update({'CategoryId': "20"});
      }if (doc['Title'].toString().toLowerCase().contains('guess - handtaschen')) {
        await doc.reference.update({'CategoryId': "30"});
      }if (doc['Title'].toString().toLowerCase().contains('shopper')) {
        await doc.reference.update({'CategoryId': "30"});
      }if (doc['Title'].toString().toLowerCase().contains('michael kors - shopper')) {
        await doc.reference.update({'CategoryId': "30"});
      }if (doc['Title'].toString().toLowerCase().contains('pumps')) {
        await doc.reference.update({'CategoryId': "25"});
      }if (doc['Title'].toString().toLowerCase().contains('top michael kors white')) {
        await doc.reference.update({'CategoryId': "16"});
      }if (doc['Title'].toString().toLowerCase().contains('bag cindy')) {
        await doc.reference.update({'CategoryId': "30"});
      }
      if (doc['Title'].toString().toLowerCase().contains('bag')) {
        await doc.reference.update({'CategoryId': "30"});
      }

    }
  }

}

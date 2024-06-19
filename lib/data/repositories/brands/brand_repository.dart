import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/brand_category_model.dart';
import 'package:t_store/features/shop/models/brand_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';

class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();
  //variables
final _db = FirebaseFirestore.instance;
//get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<void> fetchBrands() async {
    try {
      List<BrandModel> brandModels = [];
      Set<String> brandNamesSet = {};
      QuerySnapshot querySnapshot = await _db.collection('Products').get();

      // Duyệt qua các tài liệu và thêm vào danh sách brandModels
      querySnapshot.docs.forEach((doc) {
        var brand = doc['Brand'];
        if (brand != null && brand['Name'] != null && brand['Image'] != null) {
          String brandName = brand['Name'].toString();
          // Chỉ thêm model nếu tên thương hiệu chưa tồn tại trong set
          if (!brandNamesSet.contains(brandName)) {
            BrandModel brandModel = BrandModel.fromFirestore(doc);
            brandModels.add(brandModel);
            brandNamesSet.add(brandName);
            print(brandModel.name);
          }
        }
      });
     uploadDummyData(brandModels);
      print(brandModels.length);

    } catch (e) {
      print("Error fetching brands: $e");
    }
  }

  Future<void> updateProductBrands() async {
    // try {
      // Bước 1: Lấy tất cả các tài liệu từ bảng Brands và lưu trữ các cặp name và id
      QuerySnapshot brandsSnapshot = await _db.collection('Brands').get();
      Map<String, String> brandNameToIdMap = {};
      brandsSnapshot.docs.forEach((doc) {
        var brandData = doc.data() as Map<String, dynamic>;
        String brandName = brandData['Name'];
        String brandId = doc.id;
        brandNameToIdMap[brandName] = brandId;
      });

      // Bước 2: Lấy tất cả các tài liệu từ bảng Products
      QuerySnapshot productsSnapshot = await _db.collection('Products').get();

      // Bước 3 và 4: So sánh và cập nhật nếu cần thiết
      for (var productDoc in productsSnapshot.docs) {
        var productData = productDoc.data() as Map<String, dynamic>;
        var brand = productData['Brand'] as Map<String, dynamic>;

        if (brand != null && brand['Name'] != null) {
          String brandName = brand['Name'];
          if (brandNameToIdMap.containsKey(brandName)) {
            String newBrandId = brandNameToIdMap[brandName]!;
            await productDoc.reference.update({
              'Brand.Id': newBrandId,
            });
            print('Updated Product ${productDoc.id} with Brand Id $newBrandId');
          }
        }
      }

      print('Update complete');
    // } catch (e) {
    //   print("Error updating product brands: $e");
    // }
  }
  //upload to cloud
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage = Get.put(TFirebaseStorageService());
      for (var brand in brands) {
        // final file = await storage.getImageDataFromAssets(brand.image);
        // final url =
        // await storage.uploadImageData('Brands', file, brand.name);
        // brand.image = url;
        await _db
            .collection('Brands')
            .doc(brand.id)
            .set(brand.toJson());
      }
    }  catch (e) {
      throw "message: $e" ;
    }
  }

  //get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    // try{
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId',isEqualTo: categoryId).get();
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();
      if (brandIds.isEmpty) {
        print('Categories list is empty. Skipping query.');
        return [];
      }
      final brandsQuery = await _db.collection('Brands').where("Id",whereIn: brandIds).limit(10).get();
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return brands;
    // }on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    // } catch (e) {
    //   throw 'Something went wrong. Please try again';
    // }
  }

  Future<List<BrandModel>> getUniqueBrandIdsByCategoryId(String categoryId) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('Products');
    // Truy vấn các sản phẩm có CategoryId bằng với categoryId truyền vào
    QuerySnapshot snapshot = await collectionRef.where('CategoryId', isEqualTo: categoryId).get();
    Set<String> brandIds = {};
    // Duyệt qua các tài liệu và thêm Brand.Id vào set
    for (DocumentSnapshot doc in snapshot.docs) {
      var productData = doc.data() as Map<String, dynamic>;
      var brand = productData['Brand'] as Map<String, dynamic>;
      if (brand != null && brand['Id'] != null) {
        brandIds.add(brand['Id'] as String);

      }
      print(brand['Id']);
    }

    final brandsQuery = brandIds.isNotEmpty
        ? await _db.collection('Brands').where("Id", whereIn: brandIds).get()
        : await _db.collection('Brands').get();
    List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    return brands;
  }
  Future<Set<String>> getUniqueBrandIds(String categoryId) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('Products');
    // Truy vấn các sản phẩm có CategoryId bằng với categoryId truyền vào
    QuerySnapshot snapshot = await collectionRef.where('CategoryId', isEqualTo: categoryId).get();
    Set<String> brandIds = {};
    // Duyệt qua các tài liệu và thêm Brand.Id vào set
    for (DocumentSnapshot doc in snapshot.docs) {
      var productData = doc.data() as Map<String, dynamic>;
      var brand = productData['Brand'] as Map<String, dynamic>;
      if (brand != null && brand['Id'] != null) {
        brandIds.add(brand['Id'] as String);

      }
      print(brand['Id']);
    }
    return brandIds;
  }
  Future<void> genDataBrandCategory() async {
    final Map<int, Set<int>> brandCategories = {};
    List<BrandCategoryModel> data = [];
    QuerySnapshot snapshot = await _db.collection('Products').get();

    for (DocumentSnapshot doc in snapshot.docs) {
      var productData = doc.data() as Map<String, dynamic>;
      var brand = productData['Brand'] as Map<String, dynamic>;

      if (brand['Id'] != null && productData['CategoryId'] != null) {
        int brandId = int.parse(brand['Id'].toString());
        int categoryId = int.parse(productData['CategoryId'].toString());

        // Check if the brandId already exists in the map
        if (!brandCategories.containsKey(brandId)) {
          brandCategories[brandId] = {};
        }

        // Add the categoryId to the set of categories for this brandId
        brandCategories[brandId]!.add(categoryId);
      }
    }

    // Print the number of unique brandId-categoryId pairs
    int count = brandCategories.values.fold(0, (sum, set) => sum + set.length);
    print(count);

    // Print the brandId and their associated categoryIds
    brandCategories.forEach((brandId, categoryIds) {
      categoryIds.forEach((categoryId) {
        print("brandId: $brandId categoryId: $categoryId");
    BrandCategoryModel b =     BrandCategoryModel(brandId: brandId.toString(), categoryId: categoryId.toString());
        data.add(b);
      });
    });
      uploadBrandCategoryData(data);
  }








  Future<void> uploadBrandCategoryData(List<BrandCategoryModel> brandcategory) async {
    for (var v in brandcategory) {
      await _db
          .collection('BrandCategory')
          .add(v.toJson());
    }
  }
  Future<void> deleteAllDocumentsInCollection(String collectionPath) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionPath);
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Create a batch to delete documents in bulk
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    // Commit the batch
    await batch.commit();
    print("All documents in $collectionPath have been deleted.");
  }



}
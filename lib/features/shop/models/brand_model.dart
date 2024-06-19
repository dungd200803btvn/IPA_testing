import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  // Empty constructor
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return BrandModel.empty();

    // Try parsing productsCount to an integer, handle potential errors
    int? parsedProductsCount;
    try {
      parsedProductsCount = data['ProductsCount'] != null ? int.parse(data['ProductsCount'].toString()) : null;
    } catch (e) {
      // Handle parsing error (e.g., print a warning)
      print('Lỗi khi chuyển đổi productsCount thành số nguyên (int). Giá trị mặc định 0 sẽ được sử dụng.');
    }

    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: parsedProductsCount ?? 0, // Use default 0 if parsing fails
      isFeatured: data['IsFeatured'] ?? false,
    );
  }
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data()!=null){
      final data = document.data()!;
      int? parsedProductsCount;
      try {
        parsedProductsCount = data['ProductsCount'] != null ? int.parse(data['ProductsCount'].toString()) : null;
      } catch (e) {
        // Handle parsing error (e.g., print a warning)
        print('Lỗi khi chuyển đổi productsCount thành số nguyên (int). Giá trị mặc định 0 sẽ được sử dụng.');
      }
      //map json to model
      return BrandModel(
          id: document.id,
          name: data['Name'] ?? " ",
          image: data['Image'] ?? " ",
          isFeatured: data['IsFeatured'] ?? false,
          productsCount:  parsedProductsCount ?? 0,);
    }else{
      return BrandModel.empty();
    }
  }
  int generateRandomId() {
    final random = Random();
    return 1; // Từ 100 đến 1000
  }


  factory BrandModel.fromFirestore(DocumentSnapshot doc) {
    var brand = doc['Brand'];
    return BrandModel(
      id: (15 + Random().nextInt(100)).toString(),
      name: brand['Name'].toString(),
      image: brand['Image'].toString(),
      isFeatured: false, // Set isFeatured to false
      productsCount: brand['ProductsCount'] ?? 10, // You can adjust this as needed
    );
  }
}

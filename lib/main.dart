
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/dummy_data.dart';
import 'package:t_store/data/repositories/categories/category_repository.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/shop/models/product_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
//Widget binding
final WidgetsBinding widgetsBinding  = WidgetsFlutterBinding.ensureInitialized();
//GetX Local Storage
  await GetStorage.init();
  //Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then( (FirebaseApp value)=> Get.put(AuthenticationRepository()) ) ;
String filePath = 'assets/data/products.json';
final controller = Get.put(ProductController());
final productRepository = Get.put(ProductRepository());

//   // Đọc dữ liệu từ file JSON và tạo danh sách các đối tượng ProductModel
  //List<ProductModel> products = await controller.readProductsFromJson(filePath);


 // productRepository.deleteDocumentsExceptRange('Products', '001', '013');
 //productRepository.uploadDummyData1(products);

  //  final repository = Get.put(CategoryRepository());
  //  repository.uploadDummyData(TDummyData.categories);
   //productRepository.updateProducts();

  runApp(const MyApp());



}





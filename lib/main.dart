
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/shop/models/product_model.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
//Widget binding
final WidgetsBinding widgetsBinding  = WidgetsFlutterBinding.ensureInitialized();
//GetX Local Storage
  await GetStorage.init();
  // Khởi tạo GetStorage với tên bucket
  await DLocalStorage.init("my_bucket");
  //Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then( (FirebaseApp value)=> Get.put(AuthenticationRepository()) ) ;

  runApp(const MyApp());

}





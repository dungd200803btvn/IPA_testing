
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController{
  static UserRepository get instance =>Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //Function to save user data to Firestore
Future<void> saveUserRecord(UserModel user) async{
  try{
    await  _db.collection('User').doc(user.id).set(user.toJSon());
  }on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}

//fetch user detail
  Future<UserModel> fetchUserDetails() async{
    try{
     final documentSnapshot = await _db.collection("User").doc(AuthenticationRepository.instance.authUser?.uid).get();
     if(documentSnapshot.exists){
       return UserModel.fromSnapshot(documentSnapshot);
     }else{
       return UserModel.empty();
     }
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  //update user
  Future<void> updateUserDetails( UserModel updatedUser) async{
    try{
       await _db.collection("User").doc(updatedUser.id).update(updatedUser.toJSon());
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  //update any field
  Future<void> updateSingleField( Map<String,dynamic> json) async{
    try{
      await _db.collection("User").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  //remove user
  Future<void> removeUserRecord( String userId) async{
    try{
      await _db.collection("User").doc(userId).delete();
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //upload image
Future<String> uploadImage(String path,XFile image) async{
  try{
    final ref = FirebaseStorage.instance.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  }on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  }
  catch(e){
    throw 'Something went wrong. Please try again';
  }
}

}
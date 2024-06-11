import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends   GetxController{
  static OrderRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //get all orders related to current user
Future<List<OrderModel>> fetchUserOrders()async{
  try{
    final userId = AuthenticationRepository.instance.authUser!.uid;
    if(userId.isEmpty) throw 'Unable to find user information. Try again in few minute';
    final result = await _db.collection('User').doc(userId).collection('Orders').get();
    return result.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();

  }catch(e){
    throw 'Something went wrong while fetching  Order Information. Try again in few minute';
  }
}

//store new user order
Future<void> saveOrder(OrderModel orderModel,String userId) async{
  try{
await _db.collection('User').doc(userId).collection('Orders').add(orderModel.toJson());
  }catch(e){
  throw 'Something went wrong while saving  Order Information. Try again in few minute';
  }
}

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerModel extends GetxController {
  String imageUrl;
  final String targetScreen;
  final bool active;
  String? id;

  BannerModel(
      {required this.targetScreen,
      required this.active,
      required this.imageUrl,
         this.id });

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }
  static BannerModel empty() => BannerModel(id: "", targetScreen: '', active: true, imageUrl: '', );
  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data()!=null){
      final data = document.data()!;
    //map json to model
    return BannerModel(
      imageUrl: data['ImageUrl'] ?? " ",
      targetScreen: data['TargetScreen'] ?? " ",
      active: data['Active'] ?? false,
        id:document.id
    );
  }else{
      return BannerModel.empty();
    }
  }
}

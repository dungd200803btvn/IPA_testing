import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAttributeModel{
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});
  Map<String, dynamic>  toJson(){
    return {
      'Name':name,
      "Values":values
    };
  }


  static ProductAttributeModel empty() => ProductAttributeModel();
  factory ProductAttributeModel.fromJson(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data()!=null){
      final data = document.data()!;
      return ProductAttributeModel(
          name: data.containsKey('Name')? data['Name']: '',
          values:  List<String>.from(data['Values']));
    }else{
      return ProductAttributeModel.empty();
    }



  }
}
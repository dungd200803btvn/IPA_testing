import 'package:get_storage/get_storage.dart';
class DLocalStorage{
  static final DLocalStorage _instance  =DLocalStorage._internal();
  factory DLocalStorage(){
    return _instance;
  }
  DLocalStorage._internal();
  final _storage = GetStorage();
  Future<void> saveData<T>(String key, T value) async{
    await _storage.write(key,value);
  }
  T? readData<T>(String key){
    return _storage.read<T>(key);
  }
  Future<void> removeData<T>(String key) async{
    await _storage.remove(key);
  }
  Future<void> clearAll()  async{
    await _storage.erase();
  }

}
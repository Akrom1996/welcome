import 'package:get_storage/get_storage.dart';

class Database {
  final _box = GetStorage();
  void addToDb(String key, String value) async {
    await _box.write(key, value);
  }

  Future<String> readFromDb(String key) async {
    var res = await _box.read(key);
    return res;
  }

  void deleteFromDb(String key) async {
    await _box.remove(key);
  }


}

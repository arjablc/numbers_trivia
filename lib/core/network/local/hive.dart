import 'package:hive/hive.dart';

abstract class HiveHelper {
  Future<Box<dynamic>> openHiveBox(String boxName);
  Future<dynamic> getFromBox(Box<dynamic> box, dynamic key);
  Future<void> putToBox(Box<dynamic> box, dynamic key, dynamic data);
}

class HiveHelperImpl implements HiveHelper {
  @override
  Future<Box<dynamic>> openHiveBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  @override
  Future<dynamic> getFromBox(Box box, key) async {
    return await box.get(key);
  }

  @override
  Future<void> putToBox(Box box, key, data) async {
    return box.put(key, data);
  }
}

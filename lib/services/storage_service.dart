import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._internal() {
    _init(); // Call the initialization method in the constructor
  }

  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  late SharedPreferences _box;

  // Initialization method
  Future<void> _init() async {
    _box = await SharedPreferences.getInstance();
  }

  // Methods to access and manipulate data
  Future<void> writeString(String key, dynamic value) async {
    await _init(); // Ensure initialization before writing
    await _box.setString(key, value);
  }

  Future<void> writeInt(String key, dynamic value) async {
    await _init(); // Ensure initialization before writing
    await _box.setInt(key, value);
  }

  Future<void> writeBool(String key, dynamic value) async {
    await _init(); // Ensure initialization before writing
    await _box.setBool(key, value);
  }

  Future<String?> readString(String key) async {
    await _init(); // Ensure initialization before reading
    return _box.getString(key);
  }

  Future<dynamic> readInt(String key) async {
    await _init(); // Ensure initialization before reading
    return _box.getInt(key);
  }

  Future<dynamic> readBool(String key) async {
    await _init(); // Ensure initialization before reading
    return _box.getBool(key);
  }

  Future<void> remove(String key) async {
    await _init(); // Ensure initialization before removing
    await _box.remove(key);
  }

  Future<void> clearData() async {
    await _init();
    await _box.clear();
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_cache_contract.dart';

class LocalCache implements ILocalCache {
  final SharedPreferences _sharedPreferences;

  LocalCache(this._sharedPreferences);

  @override
  Map<String, dynamic> fetchMap(String key) {
    return jsonDecode(_sharedPreferences.getString(key) ?? '{}');
  }

  @override
  String fetchString(String key) {
    return _sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<void> saveMap(String key, Map<String, dynamic> json) async {
    await _sharedPreferences.setString(key, jsonEncode(json));
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> clear() async {
    _sharedPreferences.clear();
  }

  

  @override
  Future remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  List fetchList(String key) {
    return jsonDecode(_sharedPreferences.getString(key) ?? '[]');
  }

  @override
  Future<void> saveList(String key, List<String> list) async {
    await _sharedPreferences.setString(key, jsonEncode(list));
  }
  
  @override
  int fetchInt(String key) {
  return _sharedPreferences.getInt(key)?? 0;
  }
  
  @override
  Future<void> saveInt(String key, int int) async{
  await _sharedPreferences.setInt(key, int);
  }
}



abstract class ILocalCache {
  Future<void> saveMap(String key, Map<String, dynamic> json);
   Map<String, dynamic> fetchMap(String key);

  Future<void> saveString(String key, String value); 
  String fetchString(String key);

   Future<void> saveList(String key, List<String> list);
 List fetchList(String key);

   Future<void> saveInt(String key, int int);
  int fetchInt(String key);



  Future<void> clear();
  Future remove(String key);

 
}


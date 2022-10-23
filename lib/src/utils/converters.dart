import 'package:hive_flutter/hive_flutter.dart';
 part 'converters.g.dart';

/// converts values of type int to double
/// intended to use while parsing json values where type will be dynamic
/// returns value of type double
intToDouble(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw Exception("value is not of type 'int' or 'double' got type '${val.runtimeType}'");
  }
}
@HiveType(typeId: 3)
enum TemperatureUnit {
   @HiveField(0)
  kelvin,
   @HiveField(1)
  celsius,
   @HiveField(2)

  fahrenheit
}
@HiveType(typeId: 2)
class Temperature extends HiveObject {
  @HiveField(0)
  final double _kelvin;

  Temperature(this._kelvin);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9/5) - 459.67;

  double as(TemperatureUnit unit){
    switch(unit){
      case TemperatureUnit.kelvin:
        return kelvin;
      case TemperatureUnit.celsius:
        return celsius;
       
      case TemperatureUnit.fahrenheit:
        return fahrenheit;
      
    }
    
  }
}

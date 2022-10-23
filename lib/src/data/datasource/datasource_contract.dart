import '../../models/weather.dart';

abstract class IDatasource {

  Future<void> addWeatherData(Weather weather);
  Future<void> addMultipleWeatherData(List<Weather> weathers);

  Future<void> updateWeatherData(Weather weather);
  Future<List<Weather>> fetchWeatherData();

  Future<Weather?> findSingleWeatherData(Weather weather);
   Future<void> deleteSingleWeatherData(Weather weather);

  //  Future addCarouselData(Weather weather);
  // Future<List<Weather>> fetchCarouselData();

  // Future<Weather?> findSingleCarouselData(int weatherId);
}
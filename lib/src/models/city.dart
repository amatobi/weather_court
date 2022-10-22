


class City {
  String? cityName;
  String? latitude;
  String? longitude;
  String? country;
  String? iso2;
  String? adminName;
  String? capital;
  String? population;
  String? populationProper;
  City({
    this.cityName,
    this.latitude,
    this.longitude,
    this.country,
    this.iso2,
    this.adminName,
    this.capital,
    this.population,
    this.populationProper,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': cityName,
      'lat': latitude,
      'lng': longitude,
      'country': country,
      'iso2': iso2,
      'admin_name': adminName,
      'capital': capital,
      'population': population,
      'population_proper': populationProper,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['city'],
      latitude: map['lat'],
      longitude: map['lng'],
      country: map['country'],
      iso2: map['iso2'],
      adminName: map['admin_name'],
      capital: map['capital'],
      population: map['population'],
      populationProper: map['population_proper'],
    );
  }



 
}

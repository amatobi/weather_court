// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 1;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      id: fields[0] as int?,
      time: fields[1] as int?,
      sunrise: fields[2] as int?,
      sunset: fields[3] as int?,
      humidity: fields[4] as int?,
      description: fields[5] as String?,
      iconCode: fields[6] as String?,
      main: fields[7] as String?,
      cityName: fields[8] as String?,
      windSpeed: fields[9] as double?,
      temperature: fields[10] as Temperature?,
      maxTemperature: fields[11] as Temperature?,
      minTemperature: fields[12] as Temperature?,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.sunrise)
      ..writeByte(3)
      ..write(obj.sunset)
      ..writeByte(4)
      ..write(obj.humidity)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.iconCode)
      ..writeByte(7)
      ..write(obj.main)
      ..writeByte(8)
      ..write(obj.cityName)
      ..writeByte(9)
      ..write(obj.windSpeed)
      ..writeByte(10)
      ..write(obj.temperature)
      ..writeByte(11)
      ..write(obj.maxTemperature)
      ..writeByte(12)
      ..write(obj.minTemperature);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

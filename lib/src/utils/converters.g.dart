// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'converters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemperatureAdapter extends TypeAdapter<Temperature> {
  @override
  final int typeId = 2;

  @override
  Temperature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Temperature(
      fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Temperature obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._kelvin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemperatureUnitAdapter extends TypeAdapter<TemperatureUnit> {
  @override
  final int typeId = 3;

  @override
  TemperatureUnit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TemperatureUnit.kelvin;
      case 1:
        return TemperatureUnit.celsius;
      case 2:
        return TemperatureUnit.fahrenheit;
      default:
        return TemperatureUnit.kelvin;
    }
  }

  @override
  void write(BinaryWriter writer, TemperatureUnit obj) {
    switch (obj) {
      case TemperatureUnit.kelvin:
        writer.writeByte(0);
        break;
      case TemperatureUnit.celsius:
        writer.writeByte(1);
        break;
      case TemperatureUnit.fahrenheit:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperatureUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

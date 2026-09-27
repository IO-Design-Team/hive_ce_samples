// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ColoredPathAdapter extends TypeAdapter<ColoredPath> {
  @override
  final typeId = 0;

  @override
  ColoredPath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColoredPath(
      colorIndex: (fields[0] as num).toInt(),
      points: (fields[1] as List).cast<Offset>(),
    );
  }

  @override
  void write(BinaryWriter writer, ColoredPath obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.colorIndex)
      ..writeByte(1)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColoredPathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final typeId = 1;

  @override
  Offset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offset((fields[0] as num).toDouble(), (fields[1] as num).toDouble());
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dx)
      ..writeByte(1)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OffsetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
